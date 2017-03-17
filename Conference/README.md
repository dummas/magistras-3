# Pagreičio jutiklio triukšmo mažinimas

## Įvadas

Sveiki, esu Maksim Norkin iš AKSfm-15, šiandien noriu Jums pristatyti tema apie pagreičio jutiklių triukšmus.

## Problema

Kodėl pagreičio jutiklis? Remiantis prielaida, jog objektas lieka ramybės būsenoje tol, kol jį nepaveikia išorinė jėga ir turint pagreičio duomenis, juos suintegravus galima gauti objekto poziciją bet kokiu laiko momentu. Paprasta ir pigu, galim dabar pat nuleisti iš kosmoso visus gps palydovus.

Tačiau yra bet, ir tas "bet" šiuo atveju yra "triukšmas".

## Šaltinis

Iš kur atsiranda tiek daug triukšmo? Yra penki jo šaltiniai.

Pirmas šaltinis yra nuolatinė dedamoji, kuri yra skirtumas tarp matuojamos vertės ir realios vertės. Yra galimybių vertinti dedamąja matuojant jutiklį labai ilgą laiką, kurį tuo metu neveikia jokia išorinė jėga. Tačiau yra izoliacijos problemų dėl gravitacijos. Praktikoje yra naudojamas kalibravimo procesas, kurio metu įrenginys yra prijungimas prie paviršiaus, kurio orientacija gali būti labai tiksliai kontroliuojama.

Antras šaltinis yra atsitiktinis pagreičio pokytis. Jį galima laikyti baltu triukšmu (baltas triukšmas yra toks triukšmas, kurio energetinis spektras yra pastovus visiems dažniams). To pasekoje pagreičio jutiklio baltas triukšmas sukuria antro lygio atsitiktinį įverčių vaikščiojimą pozicijoje, su vidurkiu nulis ir standartiniu nuokrypiu.

```
sigma_s(t) = sigma * t^3/2 \sqrt{dt/3}
```

Trečias šaltinis yra vibraciniai triukšmai, kurie sukelia nuolatinės dedamosios stabilumo klaidą per laiką. Tokie triukšmai yra modeliuojami kaip nuolatinės dedamosios atsitiktinis judėjimas. 

Ketvirtas šaltinis yra temperatūriniai efektai. Jie sukelia vibracinius pokyčius, kas sukelia dedamosios nestabilumus. Dedamosios santykis su temperatūra labai priklauso nuo įrangos, tačiau dažniausiai yra tiesinis.

Paskutinis šaltinis yra kalibravimo klaidos. Tai yra nuolatinės dedamosios klaidos šaltinis. Jie pasirodo įverčiuose tik tuomet, kai jutiklis yra veikiamas kažkokio pagreičio jėgos.

Ką galim padaryti, kad mažinti tokias klaidas? Bandyti pritaikyti signalų filtravimą.

## Kalman filtras

Kalman filtras, pagal wikipedia, yra tiesinis kvadratinis vertintojas. Paprastas kalbant, Kalman filtas dirba su tiesinėmis sistemomis, kurios yra veikiamos Gauso baltu triukšmu, turi nebaigtą būsenos informaciją ir visa kontrolė yra matuojama kvadratine klaida.

Patį veikimą geriausiai yra paaiškinti pavyzdžiu. Tarkime turime sistemą, kurios būseną galima apibrėžti pagreičiu ir pozicija, kadangi turime tokią informaciją iš jutiklių.

