# Paskirstytų sistemų inžinerija

#### JAVA TCP ir UDP
#### Laboratorinis darbas 2, AKSfm-15, Maksim Norkin

## Užduotis

Išnagrinėti Java UDP ir TCP programas

## UDP

### Serveris

Proramą pradedame nuo tinklo prieigos atidarymo, nurodant prievado numerį

    DatagramSocket serverSocket = new DatagramSocket(9876);
    
Aprašom priėmimo ir išsiuntimo buferius

    byte[] receiveData = new byte[1024];
    byte[] sendData = new byte[1024];
    
Aprašome priėmimo paketą

    DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
    
O toliau laukiam kada klientas pasijungs per nurodytą plėtinį

    serverSocket.receive(receivePacket);
    
Kai tik gaunamas paketas, sukuriame naują kintamąjį jo informacijai išsaugoti

    String sentence = new String(receivePacket.getData());
    
Nuskaitom kliento perdavimo informaciją. Šita informacija yra reikalinga, atsakant klientui

    InetAddress IPAddress = receivePacket.getAddress();
    int port = receivePacket.getPort();
    
Gautus duomenis pakeičiam į didžiąsias raides

    String capitalizedSentence = sentence.toUpperCase();
    sendData = capitalizedSentence.getBytes();
    
Ir išsiunčiam duota informaciją klientui

    DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress, port);
    serverSocket.send(sendPacket);
    
### Klientas

Kliento programa aprašoma nuo siunčiamo prievado. Kliento pusei nėra būtina nurodyti prievado numerį, operacinė sistema plėtinį jam parenka automatiškai

    DatagramSocket clientSocket = new DatagramSocket();
    
Nuskaitę informaciją, kurią reikia išsiųsti į serverį, siunčiam paketą iki serverio

    DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress, 9876);
    clientSocket.send(sendPacket);
    
Atsakymo priėmimas iš serverio

    DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
    clientSocket.receive(receivePacket);
    
Galiausiai yra uždaromas prievadas

    clientSocket.close();
    
## TCP

### Serveris

Serverio programa pradedama nuo prievado aprašymo, nurodant konkretų prievado numerį

    ServerSocket welcomeSocket = new ServerSocket(6789);
    
Toliau seka kliento sujungimas su serveriu

    Socket connectionSocket = welcomeSocket.accept();
    
Kai klientas prisijungia prie serverio, nuskaitome visą informaciją, kurią jis turi perduoti

    BufferedReader inFromClient = new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
    clientSentence = inFromClient.readLine();
    
Norint kažkokią informaciją perduoti klientui atgal, reikia sukurti atskirą objektą, kurio pagalba galima siųsti duomenis į kliento pusę

    DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());
    outToClient.writeBytes(capitalizedSentence);

### Klientas

Klientas pradedamas nuo plėtinio aprašymo iki serverio
    
    Socket clientSocket = new Socket("localhost", 6789);

Duomenų siuntimas į serverį yra atliekamas per objektą

    DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
    outToServer.writeBytes(sentence + '\n');
    
Duomenų priėmimas iš serverio yra atliekamas per kitą objektą

    BufferedReader inFromServer = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
    modifiedSentence = inFromServer.readLine();
    
Uždarome prievadą ir atlaisviname resursus

    clientSocket.close();
    
    
    
## Išvados

Laboratorinio darbo metu buvo išaiškinta kaip yra Java programavimo kalba yra aprašomos TCP ir UDP tinklo komunikacijos protokolai. Išnagrinėtos serverio ir kliento programos.
    
