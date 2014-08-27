"""
Test pattern generator

16 bit words

    0010 0011    0101    1100
   \         /   \  /    \  /
      Glyph       FG      BG
     Address     Color   Color


"""


def longest(lst):

    longest = 0

    for i in range(len(lst)):
        if len(lst[i]) > len(lst[longest]):
            longest = i

    return longest


color = { "white" : 0,
          "silver" : 1,
          "gray" : 2,
          "black" : 3,
          "red" : 4,
          "maroon" : 5,
          "yellow" : 6,
          "olive" : 7,
          "lime" : 8,
          "green" : 9,
          "aqua" : 10,
          "teal" : 11,
          "blue" : 12,
          "navy" : 13,
          "fuchsia" : 14,
          "purple" : 15 }


glyphDict = {   "0" : 0,
                "1" : 1,
                "2" : 2,
                "3" : 3,
                "4" : 4,
                "5" : 5,
                "6" : 6,
                "7" : 7,
                "8" : 8,
                "9" : 9,
                "A" : 10,
                "B" : 11,
                "C" : 12,
                "D" : 13,
                "E" : 14,
                "F" : 15,
                "G" : 16,
                "H" : 17,
                "I" : 18,
                "J" : 19,
                "K" : 20,
                "L" : 21,
                "M" : 22,
                "N" : 23,
                "O" : 24,
                "P" : 25,
                "Q" : 26,
                "R" : 27,
                "S" : 28,
                "T" : 29,
                "U" : 30,
                "V" : 31,
                "W" : 32,
                "X" : 33,
                "Y" : 34,
                "Z" : 35,
                "[" : 36,
                "\\" : 37,
                "]" : 38,
                "^" : 39,
                "_" : 40,
                "`" : 41,
                "!" : 42,
                "\"" : 43,
                "#" : 44,
                "$" : 45,
                "%" : 46,
                "&" : 47,
                " " : 48,
                "\'" : 49,
                "(" : 50,
                ")" : 51,
                "*" : 52,
                "+" : 53,
                "," : 54,
                "-" : 55,
                "." : 56,
                "/" : 57,
                ":" : 58,
                ";" : 59,
                "<" : 60,
                "=" : 61,
                ">" : 62,
                "?" : 63,
                "@" : 64,
                "a" : 65,
                "b" : 66,
                "c" : 67,
                "d" : 68,
                "e" : 69,
                "f" : 70,
                "g" : 71,
                "h" : 72,
                "i" : 73,
                "j" : 74,
                "k" : 75,
                "l" : 76,
                "m" : 77,
                "n" : 78,
                "o" : 79,
                "p" : 80,
                "q" : 81,
                "r" : 82,
                "s" : 83,
                "t" : 84,
                "u" : 85,
                "v" : 86,
                "w" : 87,
                "x" : 88,
                "y" : 89,
                "z" : 90,
                "{" : 91,
                "|" : 92,
                "}" : 93,
                "~" : 94}

height = 50
width = 80

debug = False

string = []

for i in range(height):
    z = []
    for j in range(width):
        z.append("0")
    string.append(z)

#string.append("|----------------------------------------|")
#string.append("|           THE QUICK BROWN FOX          |")
#string.append("|                                        |")
#string.append("|           the quick brown fox          |")
#string.append("|                                        |")
#string.append("|        jumped over the lazy dog        |")
#string.append("|                                        |")
#string.append("|        JUMPED OVER THE LAZY DOG        |")
#string.append("|----------------------------------------|")
#string.append("           0 1 2 3 4 5 6 7 8 9            ")
#string.append("                                          ")
#string.append(" ~ ! @ # $ % ^ & * ( ) < > ")
#string.append(", . ? / \\ | ; : ' \" [ ] { } - = _ +")


stringColor = []

for i in range(len(string)):
    stringColor.append(["yellow", "black"])


colorCode = {}
for i in color.keys():
    colorCode.update({i : "{:0>4b}".format(color[i])})

glyphCode = {}
for i in glyphDict.keys():
    glyphCode.update({i : "{:0>8b}".format(glyphDict[i])})



emptyWord = "".join(["0"*8, colorCode["black"], colorCode["black"]])




def writeTag():
    if debug:
        f.write("".join(["; addr{", str(x+(y*80)), "} y[", str(y), "] x[", str(x) , "]\n"]));
    return None


with open("videoram.coe", "w") as f:

    f.write("memory_initialization_radix=2;\n")
    f.write("memory_initialization_vector=\n")

    lenY = len(string)

    startY = (height - lenY) // 2

    for y in range (height):

        for x in range (width):

            if y < startY:

                writeTag()

                f.write("".join([emptyWord, ",\n"]))

            elif y < startY + lenY:

                i = y - startY

                lenX = len(string[i])

                startX = (width - lenX) // 2

                if x < startX:

                    writeTag()

                    f.write("".join([emptyWord, ",\n"]))

                elif x < startX + lenX:

                    j = x - startX

                    writeTag()

                    f.write("".join([glyphCode[string[i][j]],
                    colorCode[stringColor[i][0]],
                    colorCode[stringColor[i][1]], ",\n"]))

                else:
                    writeTag()
                    f.write("".join([emptyWord, ",\n"]))

            elif y == height - 1 and x == width - 1:

                writeTag()
                f.write("".join([emptyWord, ";"]))

            else:
                writeTag()
                f.write("".join([emptyWord, ",\n"]))
