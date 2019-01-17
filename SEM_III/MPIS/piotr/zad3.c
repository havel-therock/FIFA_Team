#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define LSH_TOK_BUFSIZE 64
#define LSH_TOK_BUFSIZE2 64
#define LSH_TOK_DELIM " \t\r\n\a"

//funkcja czyta linie
char *read_line(void){
	
	char *line = NULL;
	ssize_t *bufsize = 0;
	getline(&line, &bufsize, stdin);
	return line;
}

//funkcja uruchamia komende
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
		pid_t pid;
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
				waitpid(pid, &status, WUNTRACED);
			}while(!WIFEXITED(status) && !WIFSIGNALED(status));
		}
		return 1;
	}
}

//funkcja uruchamia potok
int do_command2(char **args, char **args2){

	int args_size = (sizeof(*args)/sizeof(char*));
	int args2_size = (sizeof(*args2)/sizeof(char*));

	if(strcmp(args[args_size-1], "&") == 0){
		return do_command(NULL);
	}
	else if(strcmp(args2[args2_size-1], "&") == 0){
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
		int t2, t1, i;
		int pipefd[2];

		i = pipefd[2];
		if(i < 0){
			perror("lsh1");
			//exit(1);
		}
		fprintf(stderr, "%s\n",args2[0]);
		
		if(fork() == 0){
			if(dup2(pipefd[1], 1) != 1){
				perror("lsh2");
				//exit(1);
			}
			close(pipefd[1]);
			close(pipefd[0]);
			fprintf(stderr, "Wykonanie 1\n");
			execlp(args[0], args);
			perror("lsh3");
			//exit(1);
		}
		else if(fork() == 0){
			if(dup2(pipefd[0], 0) != 0){
				perror("lsh5");
				exit(1);
			}
			close(pipefd[1]);
			close(pipefd[0]);
			printf("Wykonanie 2\n");
			execlp(args2[0], args2);
			perror("lsh4");
			//exit(1);
		}
		else{
			close(pipefd[1]);
			close(pipefd[0]);
			wait(&t1);
			wait(&t2);
			if(WEXITSTATUS(t1) || WEXITSTATUS(t2)){
				fprintf(stderr, "wyjscie\n");
			}
		}
		return 1;
	}
}

//funkcja rozdziela linie na pojedyńcze słowa
char **split_line(char *line){
	
	int bufsize = LSH_TOK_BUFSIZE;
	int bufsize2 = LSH_TOK_BUFSIZE2;
	int position = 0;
	char **tokens = malloc(bufsize * sizeof(char*));
	char **tokens2 = malloc(bufsize * sizeof(char*));
	char *token;
	int is_pipe = 0;

	if(!tokens){
		fprintf(stderr, "lsh: error\n");
		exit(EXIT_FAILURE);
	}

	token = strtok(line, LSH_TOK_DELIM);
	while(token != NULL && is_pipe == 0){
		if(strcmp(token, "|") == 0){
			is_pipe = 1;
		}
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

	if(is_pipe == 1){
		position = 0;

		while(token != NULL){
			tokens2[position] = token;
			position++;
	
			if(position >= bufsize2){
				bufsize2 += LSH_TOK_BUFSIZE2;
				tokens = realloc(tokens2, bufsize2 * sizeof(char*));
		
				if(!tokens){
					fprintf(stderr, "lsh: error\n");
					exit(EXIT_FAILURE);
				}
			}
			token = strtok(NULL, LSH_TOK_DELIM);
		}
		tokens2[position] = NULL;
		return do_command2(tokens, tokens2);
	}
	else{
		return do_command(tokens);
	}
}

//funkja odpowiada za kolejność działań
void action(void){

	char *line;
	int status;

	do{
		printf("lsh:/  ");
		line = read_line();
		status = split_line(line);

		free(line);
	}while(status);
}

int main(int argc, char **argv){
	
	action();

	return EXIT_SUCCESS;
}
