# Q-Learning-Taxi-Gridworld
Simulation and Training through Q-Learning for the Taxi Gridworld Environment

### Introduction ###
Taxi Gridworld is a classic environment used to test reinforcement learning algorithms such as Q-learning and SARSA. It is a simplified grid world where a taxi must learn to pick up a passenger from a starting location and deliver them to the correct destination, optimizing its path.
The taxi starts from a random position and must learn to pick up the passenger and deliver them to the destination in the fewest possible steps, while avoiding obstacles placed on the grid.

### Environment Description ###
Grid Environment
The environment is modeled as a 5×5 grid, with cells numbered from 1 to 25. Each cell represents a possible taxi position.

Within the environment, four fixed positions are defined as possible pickup and drop-off points. These are named Green, Red, Yellow, and Blue, with coordinates:
• (1,1) — Red
• (1,5) — Green
• (5,1) — Yellow
• (5,4) — Blue

# Possible States

Each state is defined by a triplet:
  Taxi position → 25 possibilities
  Passenger position → 5 (4 fixed + 1 special “on board” position)
  Destination position → 4 fixed positions

Total states = 25 × 5 × 4 = 500 (including the case where the destination is the same as the passenger’s location)

# Possible Actions

At each step, the agent can perform one of the following six discrete actions:
  Move Up (Su)
  Move Down (Giù)
  Move Left (Sinistra)
  Move Right (Destra)
  Pick up passenger (Prendi passeggero)
  Drop off passenger (Lascia passeggero)

The “Pick up” action is successful only if the taxi is on the same cell as the passenger.
The “Drop off” action is successful only if the passenger is on board and the taxi is at the correct destination.

# Obstacles (Walls)

The environment has been enriched with walls, i.e., obstacles that block movement between certain adjacent cells. These walls make the path more realistic and complex.
The inclusion of obstacles serves to:
  Test the agent’s ability to plan and adapt,
  Prevent oversimplified strategies,
  Encourage intelligent exploration,
  Train the agent on a problem closer to real-world scenarios.
  
Walls are placed between:
• (3,2) e (3,3)
• (4,4) e (5,4)
• (1,3) e (2,3)

### Agent’s Goal and Reward Function ###

# Goal

The agent (the taxi) must learn an optimal policy that enables it to pick up the passenger from a starting location and deliver them to the correct destination in the fewest possible moves, avoiding obstacles.

The taxi starts without any prior knowledge of the environment—it does not know where the walls are or which path is optimal.
The only way to learn is through interaction: taking actions, observing results, and receiving rewards.

The goal is to maximize the long-term cumulative reward by selecting the best actions in each state.
To enable proper learning, an appropriate reward function must be designed.

# Reward Function

The reward function guides learning by assigning positive or negative values to actions:

Action	Reward:
  Every valid move  →  –1
  Attempting to move into a wall  →  –30
  Attempting to move outside the grid  →  –30
  Picking up the passenger correctly  →  +20
  Attempting pickup at the wrong location  →  –10
  Dropping off at the correct destination  →  +40
  Dropping off at the wrong location  →  –10

### Learning Algorithm ###

# Learning Objective

The goal is to enable the agent to learn an optimal policy, that is, a strategy defining which action to take in each state to maximize the total reward.
To achieve this, the Q-learning algorithm is used — an off-policy, model-free reinforcement learning method suitable for discrete environments such as Taxi Gridworld.

# Q-Learning

Q-learning is one of the most well-known and widely used algorithms in reinforcement learning, introduced by Christopher Watkins in 1989.
It is an off-policy method that enables an agent to learn how to make optimal decisions in an interactive environment, even without prior knowledge of the environment’s model.

The goal of Q-learning is to learn a function — called the Q-function or action-value function — that assigns to each state–action pair a value representing the expected return (future reward) achievable by following the best possible strategy from that pair onward.
Its simplest form, known as one-step Q-learning, is defined by the following equation:

Q(S_t,A_t )←Q(S_t,A_t )+ α[R_(t+1)+ γ max_a⁡〖Q(S_(t+1),a)- Q(S_t,A_t )〗]

where:
	S_t = current state;
	A_t =  executed action;
	R_(t+1) =  reward after the action;
	S_(t+1) = new state reached;
	a = evry possible actions from S_(t+1);
  α: learning rate;
  γ: discount factor.

# ε-Greedy Strategy

In reinforcement learning, the main challenge is to balance exploration and exploitation:
Exploration: trying new actions to discover better strategies.
Exploitation: choosing the best-known action to maximize the expected reward.



The ε-greedy policy addresses this trade-off as follows:
  With probability ε, the agent selects a random action (exploration).
  With probability 1 – ε, it selects the action with the highest Q-value for the current state (exploitation).

### Algorithm Implementation in MATLAB ###

The project is organized into several scripts and functions, each with a specific purpose:
  main.m – starts the training and simulation
  trainTaxiQLearning.m – implements the Q-learning algorithm
  resetEnv.m – initializes random starting conditions
  stepEnv.m – defines environment logic and reward assignment
  stateToIndex.m – converts state representations to indices
  plotEpisodeTaxi.m – visualizes agent actions per episode
  plotTaxi.m – displays the taxi, passenger, and obstacles
  plotTrainingRewards.m – plots learning progress and average rewards

### Training ###

Training uses the following parameters:
	α = 0.1		(learning rate);
	γ = 0.9		(discount factor);
	ε = 0.1		(ε-greedy);
  maxSteps=50 (maximum steps per episode).

The environment is initialized with resetEnv.m, which assigns random positions to the taxi, passenger, and destination.

With probability ε, a random action is taken, while with probability 1 – ε is taken the action max_a⁡Q(S_(t+1),a).
The next state and the obtained reward are computed through the `stepEnv.m` function, which — depending on the action performed — assigns the corresponding predefined rewards and calculates the next state as follows:
  Up → row – 1
  Down → row + 1
  Left → column – 1
  Right → column + 1

The Q-value update follows:

Q(S_t,A_t )←Q(S_t,A_t )+ α[R_(t+1)+ γ max_a⁡〖Q(S_(t+1),a)- Q(S_t,A_t )〗]

Each state (taxi, passenger, destination) is encoded into a single index using stateToIndex.m, which computes all possible combinations.

### Simulation ###

The environment is visualized in MATLAB using plotTaxi.m, where:
  The taxi is represented by a blue circle,
  The passenger by a green triangle,
  The destination by a red square,
  Obstacles by black lines.

To visualize a full episode, plotEpisodeTaxi.m is used.
To display training rewards and average rewards per episode, plotTrainingRewards.m is used.

### Conclusions ###

This project implemented and analyzed an intelligent agent in the Taxi Gridworld environment using the Q-learning algorithm.
After defining the state space, action set, and reward function, the agent was trained to correctly transport a passenger from the starting position to the destination, minimizing moves and penalties.

Special attention was given to the reward function, which guides learning, and to the ε-greedy strategy, which ensures an effective balance between exploration and exploitation.

The system was entirely developed in MATLAB, with modular code organization for clarity and reusability.
Results show that, after sufficient training episodes, the agent successfully learns optimal behavior, efficiently navigating the grid even in the presence of obstacles.

This work serves as a practical and educational example of Reinforcement Learning in a discrete environment and can be extended to more complex or realistic scenarios.

### References ###

	https://gymnasium.farama.org/environments/toy_text/taxi/
	Sutton, R.S. and Barto, A.G., 2015. Reinforcement learning: An introduction. 2nd ed. (in progress). Cambridge, Massachusetts: A Bradford Book, The MIT Press.
