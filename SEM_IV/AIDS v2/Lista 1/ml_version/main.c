#include "list.h"
#include "test.h"
#include <stdio.h>
#include <stdlib.h>

int numberOfComparisons;

int main() {
    List* list = NULL;
    int option = -1;
    int value;
    List* tempList = NULL;

    printf("OPTIONS\n");
    while(option != 0) {
		printf("1. insert\t");
		printf("2. delete\t");
        printf("3. isempty\t");
		printf("4. print\t");
        printf("5. findMTF\t");
        printf("6. findTRANS\n");
        printf("7. init\t");
        printf("8. initRandom\t");
        printf("9. testFinders\t");
        printf("\nOPTION: ");
		scanf("%d", &option);
		
		switch(option) {
			case 1:
                scanf("%i", &value);
				list = insert(list, value);
			break;
			case 2:
                scanf("%i", &value);
                tempList = delete(list, value);
                if(tempList == NULL) {
                    list = tempList;
                }
			break;
			case 3:
                printf("\n");
				printf("%i\n", isempty(list));
                printf("\n");
			break;
            case 4:
                printf("\n");
                print(list);
                printf("\n");
            break;
            case 5:
                scanf("%i", &value);
                findMTF(list, value);
            break;
            case 6:
                scanf("%i", &value);
                findTRANS(list, value);
            break;
            case 7:
                list = init(list);
            break;
            case 8:
                list = initRandom(list);
            break;
            case 9: 
                numberOfComparisons = 0;
                int testOption;
                printf("0. findMTF\n1. findTRANS\nFIND OPTION: ");
                scanf("%i", &testOption);
                switch(testOption) {
                    case 0:     
                        list = deleteTestFinders(list, testOption);
                        printf("Number of comparisons: %i\n", numberOfComparisons);
                    break;
                    case 1:
                        list = deleteTestFinders(list, testOption);
                        printf("Number of comparisons: %i\n", numberOfComparisons);
                    break;
                    default:
                        printf("ONLY 0 OR 1");
                    break;
                }

            break;
            case 0: 
            default:
                option = 0; 
            break;
		}
	}
}

