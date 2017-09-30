
[![Travis-CI Build Status](https://travis-ci.org/jtrecenti/vagalumeR.svg?branch=master)](https://travis-ci.org/jtrecenti/vagalumeR)

vagalumeR: Access the Vagalume API via R
========================================

This package allows you to access the Vagalume API via R. You can get information about specific artists/bands, as their related artists, and information about the lyrics, as the top lyrics of an artist/band and the text of a song itself.

The `vagalumeR` package is developed under control version using Git and is hosted in GitHub. You can download it from GitHub using `devtools`:

``` r
# install.packages("devtools")
devtools::install_github("brunaw/vagalumeR")
```

For exploring the content of the package, you may try:

``` r
library(vagalumeR)
packageVersion("vagalumeR")
ls("package:vagalumeR")
help(package = "vagalumeR")
```

------------------------------------------------------------------------

Some examples of the usage of this package are below:

First of all, you'll need one API key, that can be obtained at the [Vagalume Website](https://auth.vagalume.com.br/settings/api/). You'll need to register at the Website for that.

``` r
# Copy and paste your api key at the following object:
key <- "putyourapikeyhere"

#-----------
artists <- c("the-beatles", "madonna", "chico-buarque",
             "the-rolling-stones", "molejo")

library(tidyverse)
library(plyr)

ldply(map(artists, artistInfo), data.frame)
#>                  id           name views pos period uniques points
#> 1 3ade68b3gce86eda3    The Beatles 47167  28 201709   20796   37.7
#> 2 3ade68b3g1f86eda3        Madonna 12893 190 201709    6131   11.1
#> 3 3ade68b4g66c6eda3  Chico Buarque 74462  78 201709   37391   21.2
#> 4 3ade68b6g28c9eda3 Rolling Stones 25933 253 201709   13616    7.7
#> 5 3ade68b5g2f48eda3         Molejo  5362 849 201709    3052    1.9

#                  id           name  views pos period uniques points
# 1 3ade68b3gce86eda3    The Beatles 115586  24 201706   57221   42.5
# 2 3ade68b3g1f86eda3        Madonna   1519 169 201707     767   10.9
# 3 3ade68b4g66c6eda3  Chico Buarque   4603 109 201707    2124   15.2
# 4 3ade68b6g28c9eda3 Rolling Stones  28633 265 201706   15997    7.1
# 5 3ade68b5g2f48eda3         Molejo   7843 826 201706    4652    1.9
```

Where:

-   `id` is the identifier of the artist/band;
-   `name` is the name of the artist/band;
-   `views` is the number of views received by the artist/band at the Vagalume Website;
-   `pos` is the position of the artist/band at the Vagalume Ranking;
-   `period` is the period of evaluation;
-   `uniques` counts the number of unique views of the artist/band;
-   `points` is the pontuation of the artist/band at the Vagalume Ranking;

``` r
disc <- ldply(map(artists, discography), data.frame)

disc[sample(nrow(disc), 10), ]
#>              album.id                                          album.name
#> 42  3ade68b6g12b6fda3                                        Ray of Light
#> 52  3ade68b6gc408fda3 Who's That Girl: Original Motion Picture Soundtrack
#> 40  3ade68b6g48eafda3                                                GHV2
#> 66  3ade68b6g6638fda3                                       Chico Buarque
#> 97  3ade68b6g9166fda3                                            Stripped
#> 70  3ade68b6g8775fda3                                       Chico Buarque
#> 135 3ade68b6gcd18fda3                            The Rolling Stones No. 2
#> 125 3ade68b6g8683fda3                                 Between the Buttons
#> 136 3ade68b6g9c55fda3                                                12x5
#> 57  3ade68b6g5b88fda3                                               Chico
#>                                       label date                id
#> 42                                      wea 1998 3ade68b3g1f86eda3
#> 52                      Sire / London/Rhino 1987 3ade68b3g1f86eda3
#> 40  Maverick Records / Warner Bros. Records 2001 3ade68b3g1f86eda3
#> 66                                      RCA 1989 3ade68b4g66c6eda3
#> 97                                          1995 3ade68b6g28c9eda3
#> 70                                Universal 1984 3ade68b4g66c6eda3
#> 135                                   DECCA 1965 3ade68b6g28c9eda3
#> 125                                         1967 3ade68b6g28c9eda3
#> 136                                         1964 3ade68b6g28c9eda3
#> 57                            Biscoito Fino 2011 3ade68b4g66c6eda3
#>               name
#> 42         Madonna
#> 52         Madonna
#> 40         Madonna
#> 66   Chico Buarque
#> 97  Rolling Stones
#> 70   Chico Buarque
#> 135 Rolling Stones
#> 125 Rolling Stones
#> 136 Rolling Stones
#> 57   Chico Buarque

#              album.id                     album.name
# 32  3ade68b6g9758fda3         Sticky and Sweet: Live
# 155 3ade68b6g94c7fda3                   Polivalência
# 36  3ade68b6g8408fda3 I'm Going to Tell You a Secret
# 25  3ade68b6g5ff5fda3               Beatles for Sale
# 147 3ade68b6gcd18fda3       The Rolling Stones No. 2
# 38  3ade68b6g1a14fda3            Remixed & Revisited
# 27  3ade68b6g3ff5fda3               With the Beatles
# 90  3ade68b6gf8d6fda3              Meus Caros Amigos
# 89  3ade68b6g3638fda3                  Chico Buarque
# 109 3ade68b6g9166fda3                       Stripped
#                      label date                id           name
# 32                Maverick 2010 3ade68b3g1f86eda3        Madonna
# 155                        2000 3ade68b5g2f48eda3         Molejo
# 36                     wea 2006 3ade68b3g1f86eda3        Madonna
# 25                     EMI 1964 3ade68b3gce86eda3    The Beatles
# 147                  DECCA 1965 3ade68b6g28c9eda3 Rolling Stones
# 38                     wea 2003 3ade68b3g1f86eda3        Madonna
# 27                     EMI 1963 3ade68b3gce86eda3    The Beatles
# 90         Universal Music 1976 3ade68b4g66c6eda3  Chico Buarque
# 89  Universal Music Brasil 1978 3ade68b4g66c6eda3  Chico Buarque
# 109                        1995 3ade68b6g28c9eda3 Rolling Stones

xtabs(~name, disc)
#> name
#>  Chico Buarque        Madonna         Molejo Rolling Stones    The Beatles 
#>             32             27              8             50             28

# name
#  Chico Buarque        Madonna         Molejo Rolling Stones 
#             44             27              8             50 
#    The Beatles 
#             28 
```

Where:

-   `album.id` is the identifier of album;
-   `album.name` is the name of the album;
-   `label` is the record label of the album;
-   `date` is the of release of the album;

``` r
rel <- ldply(map(artists, relatedInfo), data.frame)

rel[sample(nrow(rel), 10), ]
#>                   id           name            rel.id           related
#> 50 3ade68b5g2f48eda3         Molejo 3ade68b5g5458eda3            Pixote
#> 43 3ade68b5g2f48eda3         Molejo 3ade68b5g6a58eda3 Só Pra Contrariar
#> 3  3ade68b3gce86eda3    The Beatles 3ade68b5gb7a8eda3   George Harrison
#> 22 3ade68b4g66c6eda3  Chico Buarque 3ade68b5gf7e7eda3      Gilberto Gil
#> 41 3ade68b5g2f48eda3         Molejo 3ade68b3g5d86eda3        Katinguelê
#> 19 3ade68b3g1f86eda3        Madonna 3ade68b7g61c31ea3              Glee
#> 11 3ade68b3g1f86eda3        Madonna 3ade68b7gc2b61ea3       Nicki Minaj
#> 27 3ade68b4g66c6eda3  Chico Buarque 3ade68b5gf808eda3    Caetano Veloso
#> 28 3ade68b4g66c6eda3  Chico Buarque 3ade68b5g65d7eda3      Zeca Baleiro
#> 38 3ade68b6g28c9eda3 Rolling Stones 3ade68b5gc5a8eda3     Elvis Presley

#                   id           name            rel.id
# 23 3ade68b4g66c6eda3  Chico Buarque 3ade68b5gac58eda3
# 24 3ade68b4g66c6eda3  Chico Buarque 3ade68b5gfe48eda3
# 38 3ade68b6g28c9eda3 Rolling Stones 3ade68b5gc5a8eda3
# 42 3ade68b5g2f48eda3         Molejo 3ade68b3g9d86eda3
# 28 3ade68b4g66c6eda3  Chico Buarque 3ade68b5g65d7eda3
# 1  3ade68b3gce86eda3    The Beatles 3ade68b3gee86eda3
# 34 3ade68b6g28c9eda3 Rolling Stones 3ade68b5g5018eda3
# 5  3ade68b3gce86eda3    The Beatles 3ade68b6g28c9eda3
# 26 3ade68b4g66c6eda3  Chico Buarque 3ade68b5g7d48eda3
# 13 3ade68b3g1f86eda3        Madonna 3ade68b5g8be7eda3
#                         related
# 23                    Tom Jobim
# 24            Milton Nascimento
# 38                Elvis Presley
# 42                  Art Popular
# 28                 Zeca Baleiro
# 1                   John Lennon
# 34 Creedence Clearwater Revival
# 5                Rolling Stones
# 26               Maria Bethânia
# 13              Michael Jackson
```

Where:

-   `rel.id` is the identifier of the related band/artist;
-   `related` is the name of the related band/artist;

``` r
#---------
library(network)
df <- data.frame(rel$name, rel$related)
net <- network(df)
plot(net, label = network.vertex.names(net))
```

![](README-net-1.png)

``` r
songs <- ldply(map(artists, songNames), data.frame)

songs[sample(nrow(songs), 10), ]
#>                     id           name           song.id
#> 1423 3ade68b6g28c9eda3 Rolling Stones 3ade68b7ga65b3ea3
#> 351  3ade68b3g1f86eda3        Madonna 3ade68b8ga81950b3
#> 1583 3ade68b5g2f48eda3         Molejo 3ade68b7g30c38ea3
#> 447  3ade68b3g1f86eda3        Madonna 3ade68b7gc6770ea3
#> 761  3ade68b4g66c6eda3  Chico Buarque 3ade68b7g21475ea3
#> 193  3ade68b3gce86eda3    The Beatles 3ade68b8g32739fa3
#> 1263 3ade68b6g28c9eda3 Rolling Stones 3ade68b7gfe4b3ea3
#> 303  3ade68b3gce86eda3    The Beatles 3ade68b6g92edfda3
#> 181  3ade68b3gce86eda3    The Beatles 3ade68b6gbfddfda3
#> 1570 3ade68b5g2f48eda3         Molejo 3ade68b6gfe52fda3
#>                                                          song
#> 1423            Shang A Doo Lang (recorded by Adrienne Posta)
#> 351                                                    Ariosa
#> 1583                                                  Família
#> 447                                                He's A Man
#> 761                                             Choro Bandido
#> 193  Medley: Rip It Up/shake Rattle And Roll/blue Suede Shoes
#> 1263                                                Hip Shake
#> 303                                                      Wait
#> 181                                               Lovely Rita
#> 1570                                             Doce Inimigo

#                     id           name           song.id
# 1173 3ade68b6g28c9eda3 Rolling Stones 3ade68b7gca4b3ea3
# 197  3ade68b3gce86eda3    The Beatles 3ade68b6geaddfda3
# 1156 3ade68b6g28c9eda3 Rolling Stones 3ade68b7gd94b3ea3
# 1234 3ade68b6g28c9eda3 Rolling Stones 3ade68b6g320feda3
# 1220 3ade68b6g28c9eda3 Rolling Stones 3ade68b7g6d4b3ea3
# 972  3ade68b4g66c6eda3  Chico Buarque 3ade68b7g8c788ea3
# 308  3ade68b3gce86eda3    The Beatles 3ade68b6gbcddfda3
# 755  3ade68b4g66c6eda3  Chico Buarque 3ade68b7g8fce9ea3
# 1112 3ade68b6g28c9eda3 Rolling Stones 3ade68b8gdb34b0b3
# 1154 3ade68b6g28c9eda3 Rolling Stones 3ade68b7ga94b3ea3
#                            song
# 1173                 Crazy Mama
# 197  Money (That's What I Want)
# 1156          Child Of The Moon
# 1234      Good Times, Bad Times
# 1220             Fortune Teller
# 972                Partido Alto
# 308    What's The New Mary Jane
# 755                Cem Mil Réis
# 1112           All Of Your Love
# 1154             Chantilly Lace
```

Where:

-   `song.id` is the identifier of the song;
-   `song` is the name of the song;

``` r
lyr <- ldply(map(songs$song.id[1:5], lyrics, type = "id", key = key),
             data.frame)

lyr[sample(nrow(lyr), 2), ]
#>                  id        name           song.id
#> 4 3ade68b3gce86eda3 The Beatles 3ade68b6gbdddfda3
#> 2 3ade68b3gce86eda3 The Beatles 3ade68b4g4f96eda3
#>                         song language
#> 4 A Shot of Rhythm and Blues        2
#> 2         A Hard Day's Night        2
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           text
#> 4 Well, if your hands start a-clapping and your fingers start a-popping And your feet start a-moving around And if you start to swing and sway when the band start to play A real cool and way-out sound And if you get the can't help it, when you can't sit down You feel like you gotta move around  You get a shot of rhythm and blues With just a little rock and roll on the side Just for good measure You get a pair of dancing shoes Well, with your lover by your side Don't you know you're gonna have a lot of pleasure?  Don't you worry 'bout a thing, when you start to dance and sing Until bumps come up on you And if the rhythm finally gets you and the beat gets her, too Well, here's the thing for you to do  Get a shot of rhythm and blues With just a little rock and roll on the side Just for good measure Get a pair of dancing shoes Well, with your lover by your side Don't you know you're gonna have a lot of pleasure?  Don't you worry 'bout a thing, when you start to dance and sing Until bumps come up on you And if the rhythm finally gets you and the beat gets her, too Well, here's the thing for you to do  Get a shot of rhythm and blues Get a pair of dancing shoes Get a shot of rhythm and blues Well, with your lover by your side Don't you know you're gonna have a lot of pleasure?  Don't you worry 'bout a thing, when you start to dance and sing Until bumps come up on you And if the rhythm finally gets you and the beat gets her, too Well, here's the thing for you to do Well, here's the thing for you to do
#> 2                                                                                                                                                                                                                                                                                                                                                     It's been a hard day's night And I've been workin' like a dog It's been a hard day's night I should be sleepin' like a log.  But when I get home to you, I find the things that you do Will make me feel alright.  You know I work all day To get you money to buy you things And it's worth it just to hear you say, You're gonna give me everything.  So why on earth should I moan? 'Cause when I get you alone, You know I feel okay.  When I'm home, Everything seems to be right. When I'm home, Feeling you holding me tight. Tight, yeah.  It's been a hard day's night And I've been workin' like a dog It's been a hard day's night I should be sleepin' like a log.  But when I get home to you, I find the things that you do Make me feel alright.  So why on earth should I moan? 'Cause when I get you alone, You know I feel okay.  When I'm home, Everything seems to be right. When I'm home, Feeling you holding me tight. Tight, yeah.  It's been a hard day's night And I've been workin' like a dog It's been a hard day's night I should be sleepin' like a log.  But when I get home to you, I find the things that you do Make me feel alright You know I feel alright You know I feel alright.
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         tr.text
#> 4 [Uma Dose de Rhythm And Blues] Se suas mãos começam a bater e seus dedos a estalarem E se os seus pés começarem a se mexer pra lá e pra cá E se você começa a balançar  quando a banda começa a tocar Um som realmente maneiro E se você não consegue se segurar e nem ficar sentado Você sente que precisa se mexer  Você tem uma boa dose de 'rhythm and blues' Com apenas um pouco de rock and roll na borda Só para acompanhar Pegue um par de sapatos de dança E aí, com o seu amor do seu lado Já sacou que você vai se divertir um bocado?  Não ligue pra nada quando começar a dançar e a cantar Até ficar todo arrepiado E se o ritmo finalmente se apossa de você e a batida dela Bem, aí é contigo mesmo  Sirva-se de uma boa dose de 'rhythm and blues' Com apenas um pouco de rock and roll na borda Só para acompanhar Pegue um par de sapatos de dança E aí, com o seu amor do seu lado Já sacou que você vai se divertir um bocado?  Não ligue pra nada quando começar a dançar e a cantar Até ficar todo arrepiado E se o ritmo finalmente se apossa de você e a batida dela Bem, aí é contigo mesmo  Sirva-se de uma boa dose de 'rhythm and blues' Pegue um par de sapatos de dança Sirva-se de uma boa dose de 'rhythm and blues' E aí, com o seu amor ao seu lado Já sacou que você vai se divertir um bocado?  Não ligue pra nada quando começar a dançar e a cantar Até ficar todo arrepiado E se o ritmo finalmente se apossa de você e a batida dela Bem, aí é contigo mesmo Bem, aí é contigo mesmo
#> 2                                                                                                                                                                                                                                                                 [Um Dia Difícil]   Hoje foi um dia difícil E eu tenho trabalhado como um cachorro Hoje foi um dia difícil Eu deveria estar dormindo como uma pedra  Mas quando eu chego em casa  Eu descubro que você Me faz sentir tão bem  Você sabe que eu trabalho o dia todo Para ganhar dinheiro para você para comprar as suas coisas E vale a pena só de ouvir você dizer Que você vai me dar de tudo  Então porque diabos eu deveria me importar? Porque quando eu te pego sozinha Eu me sinto tão bem  Quando estou em casa Tudo parece uma maravilha Quando estou em casa Abraçando você forte Forte  Hoje foi um dia difícil E eu tenho trabalhado como um cachorro Hoje foi um dia difícil Eu deveria estar dormindo como uma pedra  Mas quando eu chego em casa  Eu descubro que você Me faz sentir tão bem  Então porque diabos eu deveria me importar? Porque quando eu te pego sozinha Eu me sinto bem  Quando estou em casa Tudo parece uma maravilha Quando estou em casa Abraçando você forte Forte  Hoje foi um dia difícil E eu tenho trabalhado como um cachorro Hoje foi um dia difícil Eu deveria estar dormindo como uma pedra  Mas quando eu chego em casa  Eu descubro que você Me faz sentir tão bem Me faz sentir tão bem Me faz sentir tão bem

#                  id        name           song.id
# 1 3ade68b3gce86eda3 The Beatles 3ade68b4gdc96eda3
# 4 3ade68b3gce86eda3 The Beatles 3ade68b6gbdddfda3
#                         song language
# 1          A Day In The Life        2
# 4 A Shot of Rhythm and Blues        2
#                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ... <truncated>
# 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  I read the news today oh boy About a lucky man who made the grave And though the news was rather sad Well I just had to laugh I saw the photograph  He blew his mind out in a car He didn't notice that the lights had changed A crowd of people stood and stared They'd seen his face before Nobody was really sure if he was from the House of Lords.  I saw a film today oh boy The English Army had just won the war A crowd of people turned away But I just had a look Having read the book, I'd love to turn y... <truncated>
# 4 Well, if your hands start a-clapping and your fingers start a-popping And your feet start a-moving around And if you start to swing and sway when the band start to play A real cool and way-out sound And if you get the can't help it, when you can't sit down You feel like you gotta move around  You get a shot of rhythm and blues With just a little rock and roll on the side Just for good measure You get a pair of dancing shoes Well, with your lover by your side Don't you know you're gonna have a lot of pleasure?  Don't you worry 'bout a thing, when you start to dance and sing Until bumps come up on you And if the rhythm finally gets you and the beat gets her, too Well, here's the thing for you to do  Get a shot of rhythm and blues With just a little rock and roll on the side Just for good measure Get a pair of dancing shoes Well, with your lover by your side Don't you know you're gonna have a lot of pleasure?  Don't you worry 'bout a thing, when you start to dance and sing Until bumps c... <truncated>
#                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ... <truncated>
# 1                                                                                                                                                                                                                                                                                                                                                                                                                      [Um Dia na Vida]   Eu li as notícias hoje, caramba Sobre um sortudo que morreu E apesar de as notícias serem tristes Eu tive que rir Eu vi a foto  Ele estourou a cabeça em um carro Ele não percebeu que o sinal tinha mudado Uma grupo de pessoas parou e olhou Elas já tinham visto seu rosto antes Ninguém tinha certeza se ele era da Casa dos Lordes  Eu vi um filme hoje, caramba O Exército Inglês havia ganhado a guerra Um grupo de pessoas se retirou Mas eu tive que olhar Tendo lido o livro, eu adoraria te excitar  Acordei, caí da cama Passei um pente pela cabeça Encontrei meu caminho em baix... <truncated>
# 4 [Uma Dose de Rhythm And Blues] Se suas mãos começam a bater e seus dedos a estalarem E se os seus pés começarem a se mexer pra lá e pra cá E se você começa a balançar  quando a banda começa a tocar Um som realmente maneiro E se você não consegue se segurar e nem ficar sentado Você sente que precisa se mexer  Você tem uma boa dose de 'rhythm and blues' Com apenas um pouco de rock and roll na borda Só para acompanhar Pegue um par de sapatos de dança E aí, com o seu amor do seu lado Já sacou que você vai se divertir um bocado?  Não ligue pra nada quando começar a dançar e a cantar Até ficar todo arrepiado E se o ritmo finalmente se apossa de você e a batida dela Bem, aí é contigo mesmo  Sirva-se de uma boa dose de 'rhythm and blues' Com apenas um pouco de rock and roll na borda Só para acompanhar Pegue um par de sapatos de dança E aí, com o seu amor do seu lado Já sacou que você vai se divertir um bocado?  Não ligue pra nada quando começar a dançar e a cantar Até ficar todo arrepiado E ... <truncated>
```

Where:

-   `language` is the language of the song;
-   `song` is the name of the song;
-   `language` is the language of the song (1 = portuguese, 2 = english)
-   `text` is the lyrics text of the song;
-   `tr.text` is the translation text of the song;

``` r
library(tm)
# Creates the Corpus
m <- lyr[lyr$name == "The Beatles", ]

cps <- VCorpus(VectorSource(m$text),
                 readerControl = list(language = "en"))

cps <- tm_map(cps, FUN = content_transformer(tolower))
cps <- tm_map(cps, FUN = removePunctuation)
cps <- tm_map(cps, FUN = removeNumbers)
cps <- tm_map(cps, FUN = stripWhitespace)
cps <- tm_map(cps,
                FUN = removeWords,
                words = stopwords("english"))
dtm <- DocumentTermMatrix(cps)

frq <- slam::colapply_simple_triplet_matrix(dtm, FUN = sum)
frq <- sort(frq, decreasing = TRUE)

library(lattice)
# Shows the most common words in songs from The Beatles
barchart(head(frq, n = 45), xlim = c(0, NA),
          col =  "violet", 
          xlab = "Frequency",
          ylab = "Words",
          strip = strip.custom(bg = "white"))
```

![](README-freq-1.png)
