char QueroLetraA()
{
    return 'a'; // Memoria 0,1 -> 69 -> 000010
}

int main() 
{
    char letra1;
    char letra2;

    letra1 = QueroLetraA();
    letra1 = 'b';
    letra2 = letra1;
}

/*
Memoria
0000 -> 70 : letra1
0001 -> 70 : letra2
0010 -> 0
0011 -> 0



*/
