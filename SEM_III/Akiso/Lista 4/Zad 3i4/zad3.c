#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define LSH_TOK_BUFSIZE 64
#define LSH_TOK_DELIM " \t\r\n\a"

//funkcja czyta linie
char *read_line(void){
	
	char *line = NULL;
	ssize_t bufsize = 0;
	getline(&line, &bufsize, stdin);
	return line;
}

//funkcja rozdziela linie na pojedyńcze słowa
char **split_line(char *line){
	
	int bufsize = LSH_TOK_BUFSIZE;
	int position = 0;
	char **tokens = malloc(bufsize * sizeof(char*));
	char *token;

	if(!tokens){
		fprintf(stderr, "lsh: error\n");
		exit(EXIT_FAILURE);
	}

	token = strtok(line, LSH_TOK_DELIM);
	while(token != NULL){
		tokens[position] = token;
		position++;

		if(position >= bufsize){
			bufsize += LSH_TOK_BUFSIZE;
			tokens = realloc(tokens, bufsize * sizeof(char*));
	
			if(!tokens){
				fprintf(stderr, "lsh: error\n");
				exit(EXIT_FAILURE);
			}
		}
		token = strtok(NULL, LSH_TOK_DELIM);
	}
	tokens[position] = NULL;
	return tokens;
}

//funkcja uruchamia komendę
int do_command(char **args){

	int args_size = (sizeof(*args)/sizeof(char*));

	if(strcmp(args[args_size-1], "&") == 0){
		return do_command(NULL);
	}
	else{
		if(args[0] == NULL){
			return 1;
		}
		if(strcmp(args[0], "exit") == 0){
			return 0;
		}
		else if(strcmp(args[0], "cd") == 0){
			if(args[1] == NULL){
    				fprintf(stderr, "lsh: expected argument to \"cd\"\n");
  			}
			else{
    				if(chdir(args[1]) != 0){
      					perror("lsh");
   				}
			}
			return 1;
		}
		pid_t pid, wpid;
		int status;

		pid = fork();

		if(pid == 0){
			if(execvp(args[0], args) == -1){
				perror("lsh");
			}
			exit(EXIT_FAILURE);
		}
		else if(pid < 0){
			perror("lsh");
		}
		else{
			do{
				wpid = waitpid(pid, &status, WUNTRACED);
			}while(!WIFEXITED(status) && !WIFSIGNALED(status));
		}
		return 1;
	}
}

//funkja odpowiada za kolejność działań
void action(void){

	char *line;
	char **args;
	int status;

	do{
		printf("lsh:/  ");
		line = read_line();
		args = split_line(line);
		status = do_command(args);

		free(line);
		free(args);
	}while(status);
}

int main(int argc, char **argv){
	
	action();

	return EXIT_SUCCESS;
}
