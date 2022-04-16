#include <stdio.h>
#include <cs50.h>
#include <math.h>

long get_credit_card_number();
int get_card_lenght(long card);
void print_credit_card_company(long card, int card_lenght);
int luhn_algorithm(long card, int card_lenght);

int main(void)
{
    long credit_card = get_credit_card_number();
    int card_lenght = get_card_lenght(credit_card);

    if (card_lenght == 0)
    {
        return 0;
    }

    int is_valid = luhn_algorithm(credit_card, card_lenght);

    if (is_valid == 0)
    {
        return 0;
    }

    print_credit_card_company(credit_card, card_lenght);
}


// This function will prompt asking for a credit card number
long get_credit_card_number()
{
    long credit_card = 0L;

    do 
    {
        credit_card = get_long("Please give me your credit card number: ");
    } 
    while (credit_card < 1L || credit_card > 9999999999999999L);

    return credit_card;
}


//This function will check the lenght of the credit card
int get_card_lenght(long card)
{
    int count = 0;

    while (card > 0L)
    {
        card = card / 10L;
        count++;
    }

    // Check if it is a valid credit card, if invalid will print a message and return zero
    if (count != 13 && count != 15 && count != 16)
    {
        printf("INVALID\n");
        return 0;
    }

    return count;
}

// This function will print the company name
void print_credit_card_company(long card, int card_lenght)
{
    // This loop will get the first too digits
    while (card > 100L)
    {
        card = card / 10L;
    }

    int company_id = card;

    // This will compare and find one of the valid credit card companies
    if (company_id > 50 && company_id < 56 && card_lenght == 16)
    {
        printf("MASTERCARD\n");
        return;
    }

    if ((company_id == 34 || company_id == 37) && (card_lenght == 15))
    {
        printf("AMEX\n") ;
        return;
    }

    if ((company_id / 10 == 4) && (card_lenght == 13 || card_lenght == 16 || card_lenght == 19))
    {
        printf("VISA\n");
        return;
    }

    // Or it will return a invalid
    printf("INVALID\n");
}

// This will return 1 if it is a valid credit card, or zero if not
int luhn_algorithm(long card, int card_lenght)
{
    //The basic sum
    int sum = 0;

    // A loop through the card digits, always removing the last one
    for (int i = 1; i <= card_lenght; i++)
    {
        // This is the last digit
        int digit = card % 10L;

        // If this is a even digit based on the loop index, will change the digit value
        if (i % 2 == 0)
        {
            digit *= 2;

            if (digit > 9)
            {
                digit -= 9;
            }
        }

        // Otherwise will add the digit unchanged
        sum += digit;

        // This will remove the last digit
        card /= 10L;
    }

    // This will check if the card is invalid
    if (sum % 10 != 0)
    {
        printf("INVALID\n");
        return 0;
    }

    // Otherwise will return a 1
    return 1;
}