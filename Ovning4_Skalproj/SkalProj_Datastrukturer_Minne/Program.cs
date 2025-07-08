namespace SkalProj_Datastrukturer_Minne

/*
 1.  Stack och heap.   
Stack – LIFO (last in first out). Används för statisk minneshantering med LIFO tänk.. Variablarna ”lagras” direkt i minnet och är lätta att få tag i.. När en metod anropas som kontaktar en ytterligare metod och så vidare så pausas svaret innan alla metoder har anropats och metodens returnerar sitt värde.
Stacken är trådspecifik. Ansvarig för att hålla reda på koden och vilken kod som körs. Stacken är självförsörjande, vilket innebär att den i princip tar hand om sin egen minneshantering. 

Heap
Används för dynamisk minneshantering. Är applikationsspecifik. Ansvarig för att hålla reda på våra objekt.
Det finns ingen begränsning för vad som kan nås i stacken.   Heap har Garbage Collection (GC). Hanterar reference types

Båda lagras i datorns RAM-minne.

2.     Value type o reference types
Value types och reference types är de två huvudkategorierna i C#. En variabel av en value type innehåller en instans av typen. Ligger i System.ValueType och är t ex bool, double eller char.
Reference type skiljer sig och innehåller en referens till en instans, d v s inte innehåller det faktiska värdet. Den ärver av System.Object och är t ex en class, object eller interface.

3.    
a.     Du skapar x och ger den ett värde av 3. Du skapar y och skriver y = x men samtidigt så ger du y ett värde av 4. Här ändras inte värdet x. Du returnerar här det värdet du eftersöker x vilket är 3.  En value type.
b.     Du skapar ett objekt med värdet x. Därefter skapar du ett objekt med värdet y. y = 3 blir tre men därefter så ändrar du y till 4. Du returnerar värdet y som då blir 4. En reference types
  */
{
    class Program
    {
        static void Main()
        {
            while (true)
            {                                                                                   //helst i en egen metod. ligger i en en while loop tills programmet dör. 
                Console.WriteLine("Please navigate through the menu by inputting the number \n(1, 2, 3 ,4, 0) of your choice"
                    + "\n1. Examine a List"
                    + "\n2. Examine a Queue"
                    + "\n3. Examine a Stack"
                    + "\n4. CheckParanthesis"
                    + "\n0. Exit the application");

                char input = ' ';                                                               //Creates the character input to be used with the switch-case below. Använder input för att se om något skrivits. 
                try
                {
                    input = Console.ReadLine()![0];                                             //Tries to set input to the first char in an input line
                }
                catch (IndexOutOfRangeException)                                                //If the input line is empty, we ask the users for some input.
                {
                    Console.Clear();
                    Console.WriteLine("Please enter some input!");
                }
                switch (input)                                                                  //använder switch statement för att kalla på respektive metod
                {
                    case '1':
                        ExamineList();
                        break;
                    case '2':
                        ExamineQueue();
                        break;
                    case '3':
                        ExamineStack();
                        break;
                    case '4':
                        CheckParanthesis();
                        break;
                    case '0':
                        Environment.Exit(0);
                        break;
                    default:
                        Console.WriteLine("Please enter some valid input (0, 1, 2, 3, 4)");
                        break;
                }
            }
        }


        static void ExamineList()                                                               //list har en underliggande array med en fix storlek. hu ren lista fungerar. en lista är dynamisk. ökar storlek
        {

            var list = new List<string>();
            bool finish = false;                                                                //kontrollvariabel för att se så att användaren är nöjd. avbryta
            Console.Clear();                                                                    //städa upp consolen.

            Console.WriteLine("Examine List:" +
                "\n'+': Add new element from list" +
                "\n'-': Remove element from list" +
                "\n'p': Print all in list" +
                "\n'0': Exit back to main menu");

            do                                                                                  //lägga listan utanför scopet. då förnyas listan o det vill vi inte 
            {
                var input = Console.ReadLine();
                var nav = input[0];                                                             //om de skriver +Adam. Resten ska läggas till listan. Plocka ut den första karaktären i inputen för att använda i switch
                var value = input.Substring(1);                                                 //de faktiska värdet. outputen.

                switch (nav)
                {
                    case '+':
                        AddToList(value, list);
                        break;
                    case '-':
                        RemoveFromList(value, list);
                        break;
                    case 'p':
                        PrintList(list);
                        break;
                    case '0':
                        finish = true;
                        Console.Clear();
                        break;
                    default:
                        Console.WriteLine("^Please press +, -, p or 0. \n");
                        break;
                }
            } while (!finish);
        }

        private static void PrintList(List<string> list)
        {
            foreach (var item in list)
            {
                Console.WriteLine(item);
            }
        }

        private static void RemoveFromList(string value, List<string> list)
        {
            var removalSuccessfull = list.Remove(value);
            if (removalSuccessfull)
            {
                Console.WriteLine($"\"{value}\" has been removed from the list ");
                Console.WriteLine($"Current number of elements: {list.Count}");
                Console.WriteLine($"Current capacity of list: {list.Capacity}");
            }
            else
            {
                Console.WriteLine($"\"{value}\" not found in list");
            }
        }

        private static void AddToList(string value, List<string> list)
        {
            //lägger till en lista. Capacity och count
            list.Add(value);
            Console.WriteLine($"\"{value}\" has been added to the list");
            Console.WriteLine($"Current number of elements: {list.Count}");                     //Hur många saker finns det i listan nu?
            Console.WriteLine($"Current capacity of list: {list.Capacity}\n");                  //Hur "stor" är listan nu?    
        }

        static void ExamineQueue()
        {
            var queue = new Queue<string>();
            bool finish = false;
            Console.Clear();

            Console.WriteLine("Examine Queue:" +
                "\n'+': Add new element from queue" +
                "\n'p': Print all in queue" +
                "\n'0': Exit back to main menu");

            do
            {
                var input = Console.ReadLine();
                var nav = input[0];
                var value = input.Substring(1);                                                 //de faktiska värdet. outputen.

                switch (nav)
                {
                    case '+':
                        AddToQueue(value, queue);
                        break;
                    case '-':
                        RemoveFromQueue(queue);
                        break;
                    case 'p':
                        PrintQueue(queue);
                        break;
                    case '0':
                        finish = true;
                        Console.Clear();
                        break;
                    default:
                        Console.WriteLine("^Please press +, -, p or 0. \n");
                        break;
                }
            } while (!finish);
        }

        //Simulera ICA-kön
        private static void PrintQueue(Queue<string> queue)
        {

        }

        private static void RemoveFromQueue(Queue<string> queue)
        {

        }

        private static void AddToQueue(string value, Queue<string> queue)
        {
            queue.Enqueue(value);
            Console.WriteLine($"\"{value}\" has been added to the queue.\n");
        }

        static void ExamineStack()
        {

        }

        static void CheckParanthesis()
        {

        }
    }

}


