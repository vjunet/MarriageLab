# MATLAB Fall 2014 – Research Plan

> * Group Name: MarriageLab
> * Group participants names: Samuel Imfeld, Valentin Junet
> * Project Title: Stable Marriage Problem

## General Introduction

The stability problem is an interesting mathematical problem and we’re inclined in analysing it a bit further. This algorithm can be used in the college admission and, obviously, to match people according to their preferences. This problem was studied by Gale and Shapley in 1962 in an economical context about stability. They developed an algorithm which always finds the best possible stability state.

## The Model

We want to reproduce the algorithm presented by Gale and Shapley. However, we want to modify the input data a little bit. These modifications are:
* the men/women willing to marry won’t have complete information about the others, meaning they don’t necessarily know each other
* they can also change their preferences during the process of match-making.
We think that this model is more likely to be observed in everyday life.

## Fundamental Questions

As proven in the paper, the original algorithm always ends up in a stable state. We would now like to study what the repercussions on the stability are when applying the modifications, as described above.
* How many instable couples are there once the algorithm terminates? (According to the definition of stability in the paper from Shapley and Gale)
* How does the lack of information correspond to the stability?
* How is the frequency of the preference changes related to the stability?

## Expected Results

We expect the following results:
* In general, the algorithm will not produce a stable state when the described modifications are made (unless one changes the algorithm)
* The lack of information will lead to a more or less stable state, but leaving some people without a partner.
* The preference changes will almost always lead to an unstable state. We expect that the number of unstable couple corresponds in some way to the number of preference changes

## References 

* http://www.econ.ucsb.edu/~tedb/Courses/Ec100C/galeshapley.pdf, 13.10.2014
* https://www.youtube.com/watch?v=Qcv1IqHWAzg, 13.10.2014
* https://www.youtube.com/watch?v=LtTV6rIxhdo, 13.10.2014

## Research Methods

agent based simulation: Every man/woman has a preference list. The matches are made according to the specified preferences.

## Other
