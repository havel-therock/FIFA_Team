#include<stdio.h>
#include<string.h>
#define NO_OF_CHARS 256

int k(char *P, int m, int q, int a)
{
    if (q < m && a == P[q])
        return q + 1;

    for (int ns = q; ns > 0; ns--)
    {
    	int i;
        if (P[ns - 1] == a)
        {
            for (i = 0; i < ns - 1; i++)
            {
                if (P[i] != P[q - ns + 1 + i])
                    break;
            }
            if (i == ns - 1)
                return ns;
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

void finiteAutomatonMatcher(char *T, char *P, int m)
{
    int delta[m + 1][NO_OF_CHARS];
    computeTF(P, delta);

	int n = strlen(T);
    int q = 0;
    for (int i = 0; i < n; i++)
    {
        q = delta[q][T[i]];
        if (q == m)
        {
        	int s = i - m + 1;
            printf("\n Pattern found at index %d", s);
        }
    }
}
 
int main()
{
    char *T = "ABaBABAABAB";
    char *P = "ABAB";

    int m = strlen(P);

	finiteAutomatonMatcher(T, P, m);
    return 0;
}
