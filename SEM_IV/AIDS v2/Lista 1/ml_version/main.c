#include "list.h"
#include "test.h"
#include <stdio.h>
#include <stdlib.h>

int numberOfComparisons;

// List* init(List* list) {
//     for(int i = 1; i <= 100; i++) {
//         list = insert(list, i);
//     }
//     return list;
// }

// List* initRandom(List* list) {
//     int interval = 100;
//     int tab[100];
//     int iterator, guard;

//     for(int i = 0; i < 100; i++) {
//         tab[i] = i + 1;
//     }

//     for(int i = 0; i < 100; i++) {
//         guard = rand() % interval;
//         iterator = 0;
//         for(int j = 0; j < 100; j++) {
//             if(tab[j] != 0) {                
//                 if(iterator == guard) {
//                 list = insert(list, tab[j]);
//                 tab[j] = 0;
//                 interval--;
//                 break;
//                 }
//                 else {
//                     iterator++;
//                 }
//             }
//         }
//     }

//     return list;
// }

// int findValue(List* list, int searchedValue) {
//     if(isempty(list)) {
//         printf("\nLIST IS EMPTY\n\n");
//         return 0;
//     }
//     else if(list -> value == searchedValue){
//         numberOfComparisons++;
//         return 1;
//     }
//     else {
//         while(list -> nextElement != NULL) {
//             numberOfComparisons++;
//             if(list -> nextElement -> value != searchedValue) {
//                 list = list -> nextElement;
//             }
//             else {
//                 return 1;
//             }
//         }
//         return 0;
//     }
// }

// List* deleteTest(List* list, int searchedValue) {
//     for(int i = 1; i <= 100; i++) {
//         findValue(list, i);
//     }
//     list = delete(list, searchedValue);

//     return list;
// }

// List* deleteTestFinders(List* list, int function) {
//     for(int i = 100; i >= 1; i--) {
//         for(int i = 1; i <= 100; i++) {
//             if(function) {
//                 findTRANS(list, i);
//             }
//             else {
//                 findMTF(list, i);
//             }
//         }
//         list = delete(list, i);
//     }
//     return list;
// }

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

