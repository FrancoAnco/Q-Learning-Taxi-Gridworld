# Q-Learning-Taxi-Gridworld
Simulation and Training through Q-Learning for the Taxi Gridworld Environment


### Introduzione ###
Taxi Gridworld è un ambiente classico usato per sperimentare algoritmi di reinforcement learning, come Q-learning o SARSA. È una griglia semplificata in cui un taxi deve imparare a trasportare un passeggero da una posizione di partenza a una destinazione corretta, ottimizzando il percorso.
Il taxi parte da una posizione casuale e deve imparare a prendere il passeggero e portarlo a destinazione nel minor numero di passi, evitando gli ostacoli posti sulla griglia.


 
### Descrizione dell’ambiente ###
Ambiente Griglia
L'ambiente è modellato come una griglia 5×5, con celle numerate da 1 a 25. Ogni cella rappresenta una possibile posizione per il taxi.

Nell’ambiente sono definite quattro posizioni fisse usate come possibili punti di prelievo del passeggero e destinazione di consegna. Queste hanno i nomi di Green, Red, Yellow, Blue.
Le coordinate delle posizioni sono:
• (1,1) — Red
• (1,5) — Green
• (5,1) — Yellow
• (5,4) — Blue
 
 # Possibili Stati

Ogni stato è definito da una tripla:
	Posizione del taxi → 25 possibili
	Posizione del passeggero → 5. Composte da 4 posizioni fisse + 1 posizione speciale "a bordo" 
	Posizione di destinazione → 4 fisse

Stati totali=25×5×4=500

# Possibili Azioni

A ogni passo, l’agente può compiere una delle seguenti azioni:
	Su
	Giù
	Sinistra
	Destra
	Prendi passeggero
	Lascia passeggero

In totale ci sono sei azioni discrete. L’azione “Prendi” può avere successo solo se il taxi si trova sulla stessa casella del passeggero. L’azione “Lascia” ha successo solo se il passeggero è a bordo e la posizione corrisponde alla destinazione.
 
 # Posizionamento ostacoli

L’ambiente è stato arricchito con muri, ovvero ostacoli che bloccano il movimento tra alcune celle adiacenti. I muri sono rendono il percorso più realistico e complesso.
L’inserimento di ostacoli serve per:
	testare la capacità dell’agente di pianificare e adattarsi,
	evitare strategie semplicistiche,
	promuovere l’esplorazione intelligente,
	allenare l’agente su un problema più vicino a scenari reali.

Le coordinate dei muri sono:
• tra (3,2) e (3,3)
• tra (4,4) e (5,4)
• tra (1,3) e (2,3)
 
### Obiettivo dell’Agente e Reward Function ###

# Obiettivo

L’agente, ovvero il taxi, ha come scopo principale quello di imparare una politica ottimale che gli permetta di prelevare un passeggero da una posizione iniziale predefinita e trasportarlo fino alla destinazione corretta, nel minor numero di mosse possibile, evitando gli ostacoli.
Questo obiettivo deve essere raggiunto senza conoscenza a priori dell’ambiente: il taxi non sa dove sono i muri, né qual è il percorso migliore. L’unico modo per imparare è interagire con l’ambiente, provando azioni e osservando le conseguenze in termini di ricompense.
Il taxi ha a disposizione un set finito di azioni e deve decidere quando e dove eseguirle per ottenere la massima ricompensa cumulativa nel lungo termine.
Per permettere all’agente di imparare correttamente ad ogni episodio è necessario costruire una Reward Function appropriata.

# Reward Function

La funzione di ricompensa è il meccanismo attraverso cui l’ambiente comunica all’agente se le sue azioni sono "buone" o "cattive". Essa guida l’apprendimento rinforzando comportamenti desiderati e scoraggiando quelli inutili o dannosi.

Ricompense corrispondenti ad ogni azione:
	Ad ogni passo valido	→	-1
	Movimento dove è presente un muro		→	-30
	Movimento verso esterno della griglia	→	-30
	Carica passeggero nella posizione corretta	→	+20
	Carica passeggero nella posizione non corretta	→	-10
	Scarico del passeggero a destinazione		→	+40
	Scarico del passeggero in posizione diversa da destinazione 	→	-10

### Algoritmo di Apprendimento ###

# Scopo dell’Apprendimento

L’obiettivo è far sì che l’agente impari una politica ottimale, cioè una strategia che dica quale azione compiere in ogni stato per massimizzare la ricompensa totale. Per farlo si usa l’algoritmo di Q-learning, un metodo di reinforcement learning off-policy e model-free, adatto per ambienti discreti come Taxi Gridworld.

# Q-Learning

Q-learning è uno degli algoritmi più noti e utilizzati nel reinforcement learning, introdotto da Christopher Watkins nel 1989. Si tratta di un metodo off-policy che permette a un agente di imparare a prendere decisioni ottimali in un ambiente interattivo, anche senza conoscere a priori il modello dell’ambiente.

L’obiettivo del Q-learning è apprendere una funzione, chiamata funzione Q o funzione di valore d’azione, che assegna a ogni coppia stato-azione un valore che rappresenta il ritorno atteso (ricompensa futura) ottenibile seguendo la migliore strategia possibile a partire da quella coppia. La sua forma più semplice, chiamata Q-learning a un passo (one-step Q-learning), è definita dalla seguente equazione:

Q(S_t,A_t )←Q(S_t,A_t )+ α[R_(t+1)+ γ max_a⁡〖Q(S_(t+1),a)- Q(S_t,A_t )〗]

Dove:
	S_t = stato attuale,
	A_t = azione eseguita,
	R_(t+1) = ricompensa ottenuta dopo l’azione,
	S_(t+1)= nuovo stato raggiunto,
	a = tutte le possibili azioni da S_(t+1),
	α = learning rate (quanto apprendo da nuove esperienze),
	γ = discount factor (quanto tengo conto delle ricompense future).

# Strategia ε-greedy

Nel reinforcement learning, una delle sfide principali è bilanciare exploration
ed exploitation:
	Exploration: l’agente prova azioni non ancora ottimizzate per scoprire nuove strategie migliori.
	Exploitation: l’agente sceglie l’azione che conosce come la migliore finora, massimizzando il guadagno atteso.



La strategia ε-greedy risolve questo compromesso in modo semplice:
In ogni stato, l’agente sceglie l’azione nel seguente modo:
	Con probabilità ε, seleziona un’azione casuale (exploration).
	Con probabilità 1–ε, seleziona l’azione con il valore Q massimo per quello stato (exploitation).

 ### Costruzione algoritmo su Matlab ###

Il progetto è organizzato in più script e funzioni, ognuno con un ruolo preciso. Gli script principali sono:
	main.m: avvia l’addestramento e la simulazione.
	trainTaxiQLearning.m: implementa l’algoritmo di Q-learning.
	resetEnv.m: genera gli stati iniziali casuali per gli episodi.
	stepEnv.m: gestisce la logica dell’ambiente a ogni azione.
	stateToIndex: conversione tra rappresentazioni degli stati.
	plotEpisodeTaxi.m: visualizza le azioni dell’agente ad ogni passo.
	plotTaxi.m: visualizza Taxi, passeggero e ostacoli.
	plotTrainingRewards.m: Visualizza la funzione di apprendimento.

### Training ###

Gli script usati per il training sono: “trainTaxiQLearning”, “resetEnv”, “stepEnv”.

Vengono scelti i valori:
	α = 0.1		(learning rate);
	γ = 0.9		(discount factor);
	ε = 0.1		(ε-greedy).
	maxSteps = 50	(numero massimo di step per episodio)
  
Inizialmente l’Environment viene inizializzato con la funzione “resetEnv.m”, che restituisce posizioni randomiche del taxi, passeggero e destinazione.

Con probabilità ε si compie un’azione casuale, mentre con probabilità 1- ε si trova max_a⁡Q(S_(t+1),a).
Si calcola il prossimo stato e la reward ottenuta, attraverso la funzione “stepEnv.m”, che a seconda dell’azione compiuta, attribuisce le reward assegnate precedentemente e calcola il prossimo stato come segue:
	Su = riga - 1	;
	Giù = riga + 1;
	Sinistra = colonna – 1;
	Destra = colonna + 1.
  
Infine, viene trovato Q(S_t,A_t )  con la formula:

Q(S_t,A_t )←Q(S_t,A_t )+ α[R_(t+1)+ γ max_a⁡〖Q(S_(t+1),a)- Q(S_t,A_t )〗]

Lo stato viene considerato come singolo numero, esso contiene posizione spaziale del taxi, del passeggero e della destinazione. Per trasformare questa terna in un singolo numero bisogna calcolare ogni possibile combinazione e numerarla. Per fare questo si usa la funzione “stateToIndex.m”.

### Simulazione ###

L’ambiente è stato visualizzato tramite un plot di Matlab, nella funzione ”plotTaxi.m” che rappresenta il taxi con un cerchio blu, il passeggero con un triangolo verde e la destinazione con un quadrato rosso, mentre gli ostacoli con delle linee nere.

Per visualizzare la simulazione di un episodio, viene usato “plotEpisodeTaxi.m”

Infine, per visualizzare il grafico delle reward e reward medie per ogni episodio, viene usato “plotTrainingRewards.m”

### Conclusioni ###

Il progetto ha previsto l’implementazione e l’analisi di un agente intelligente all’interno dell’ambiente Taxi Gridworld, sfruttando l’algoritmo di Q-learning. Dopo aver definito in modo strutturato lo spazio degli stati, delle azioni e la funzione di ricompensa, l’agente è stato addestrato per raggiungere l’obiettivo di trasportare correttamente un passeggero da una posizione di partenza a una destinazione, minimizzando il numero di mosse e penalità.
Particolare attenzione è stata dedicata alla modellazione della funzione di reward, necessaria per guidare l’apprendimento dell’agente, e alla strategia ε-greedy, che ha garantito un efficace equilibrio tra esplorazione e sfruttamento.
L’intero sistema è stato realizzato in MATLAB, organizzando il codice in moduli separati per favorire chiarezza e modularità. I risultati ottenuti hanno dimostrato che, dopo un numero sufficiente di episodi, l’agente riesce ad apprendere un comportamento ottimale, navigando con efficienza nella griglia anche in presenza di ostacoli.
Il lavoro svolto fornisce un esempio pratico e didattico dell’applicazione del Reinforcement Learning a un ambiente discreto, e rappresenta un punto di partenza per lo studio di tecniche più avanzate o per l’estensione dell’ambiente a scenari più complessi.

### Bibliografia ###

	https://gymnasium.farama.org/environments/toy_text/taxi/
	Sutton, R.S. and Barto, A.G., 2015. Reinforcement learning: An introduction. 2nd ed. (in progress). Cambridge, Massachusetts: A Bradford Book, The MIT Press.

