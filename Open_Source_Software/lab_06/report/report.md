# Atvirojo kodo įranga mokslui, verslui ir valdymui

#### Namų darbas 7, AKSfm-15, Maksim Norkin

## Užduotis

Įdiegti atviro kodo duomenų bazę, pagrįsti įrangos pasirinkimą, atlikti duomenų bazės konfigūraciją ir atlikti bazinius žingsnius su pačia duomenų baze.

## Duomenų bazės diegimas

Laboratorinio darbo metu darbo palengvinimui bus panaudotas ``vagrant``.

Darbas pradedamas identiškai pirmam laboratoriniam darbui, nuo virtualios mašinos inicijavimo.

    vagrant init https://github.com/kraksoft/vagrant-box-debian/releases/download/7.8.0/debian-7.8.0-amd64.box

Po virtualios mašinos inicijavimo, pradedamas darbas su pačia virtualia mašina.

Pirmiausiai atnaujiname programinės įrangos paketą

    apt-get update
    
Po šito žingsnio galime iškarto diegti pasirinktos duomenų bazės serverį. Šio darbo metu buvo pasirinkta ``PostgreSQL`` duomenų bazė, dėl jos atviros licencijos (``The PostgreSQL Licence``). Duomenų bazės diegimas susideda iš dviejų paketų
    
    apt-get install postgresql postgresql-contrib -y
    
Pirmas paketas yra pati duomenų bazė, antras paketas yra darbui su duomenų baze būtinas įrankių rinkinys.

Sekantis žingsnis yra sukurti naudotoją duomenų bazėje ir sukurti jo asmeninę duomenų bazę

    # Create user
    sudo -u postgres createuser --echo --createdb --no-createrole --login --no-superuser test1
    # Create user database
    sudo -u postgres createdb test1
    
Norint prisijungti prie duomenų bazės su slaptažodžiu, reikia atlikti vieną pakeitimą duomenų bazės konfigūracijoje

    sed -i 's/local all all peer/local all all md5/g' /etc/postgresql/9.1/main/pg_hba.conf

Pakeisti ``peer`` sąsaja į ``md5``, tuomet naudotojas gali prisijungti prie duomenų bazės su savo slaptažodžiu.

Kadangi buvo pakeista konfigūracija duomenų bazėje, reikia perkrauti duomenų bazę, kad įsigaliotų visi pakeitimai

    service postgresql restart
    
Tolimesnis darbas yra paskirti naudotojui slaptažodį

    sudo -u postgres psql -c "ALTER ROLE test1 WITH PASSWORD 'test1'"
    
Sekantis žingsnis yra sukurti norimą duomenų bazę

    PGPASSWORD='test1' psql --username=test1 -c "CREATE DATABASE mydb"
    
Sukurti lentelę

    PGPASSWORD='test1' psql --username=test1 -c "CREATE TABLE test (
        id SERIAL,
        name text not null,
        phone text not null
    )"
    
Galima pažiūrėti kas šiuo metu yra toje lentelėje

    PGPASSWORD='test1' psql --username=test1 -c "SELECT * FROM test"
    
Ir įvesti kažkokius pavyzdinius duomenis

    PGPASSWORD='test1' psql --username=test1 \ 
    -c "INSERT INTO test (name, phone) VALUES ('Vardenis', '31241213')"
    
Norint peržiūrėti duomenis, vykdoma tokia pati komanda, kuri buvo aprašyta ankščiau

    PGPASSWORD='test1' psql --username=test1 -c "SELECT * FROM test"

Ekrane turi matytis rezultatas

    ==> default:  id |   name   |  phone
    ==> default: ----+----------+----------
    ==> default:   1 | Vardenis | 31241213
    
## Išvados

Savarankiško darbo metu buvo pasirinkta ir įdiegta duomenų bazė, atlikti konfigūracijos darbai, kurie susidėjo iš naudotojo su slaptažodžiu sukūrimo. Darbui su duomenų baze pavyzdžiui, buvo sukurta labai paprasta duomenų lentelė ir įterptas naujas įrašas.
