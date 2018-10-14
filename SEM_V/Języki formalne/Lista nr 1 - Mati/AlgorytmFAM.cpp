#include<stdio.h>
#include<string.h>
#define NO_OF_CHARS 256

int k(char *P, int m, int q, int a)
{
    if (q < m && a == P[q])
        return q + 1;
// Program rozpoczyna działanie z największą sensowną wartością k, a następnie zmniejsza k aż znajdzie prefiks
    for (int k = q; k > 0; k--)
    {
    	int i;
        if (P[k - 1] == a)
        {
            for (i = 0; i < k - 1; i++)
            {
                if (P[i] != P[i + q - (k - 1)])
                    break;
            }
            if (i == k - 1)
                return k;
        }
    }

    return 0;
}

void computeTF(char *P, int sigma[][NO_OF_CHARS])
{
    int m = strlen(P);

    for (int q = 0; q <= m; ++q)
        for (int a = 0; a < NO_OF_CHARS; ++a)
            sigma[q][a] = k(P, m, q, a);
}

void finiteAutomatonMatcher(char *T, int delta[][NO_OF_CHARS], int m)
{


	int n = strlen(T);
    int q = 0;
    for (int i = 0; i < n; i++)
    {
        q = delta[q][T[i]];
        if (q == m)
        {
        	int s = i - m + 1;
            printf("\n Wzorzec występuje z przesunięciem s = %d", s);
        }
    }
}

int main()
{
    char *T = "ABaBABAABAB";
    char *P = "ABAB";
    printf(" T = %s, P = %s\n", T, P);
    printf("%c", 350);

    int m = strlen(P);
    int delta[m + 1][NO_OF_CHARS];
    computeTF(P, delta);

	finiteAutomatonMatcher(T, delta, m);
    return 0;
}
