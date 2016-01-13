### Structure

- paper.tex: Root document contains metadata and includes the following files
- 00-abstract.tex: Abstract text body
- 01-intro.tex: Introduction, problem specification, motivation and algorithm description
- 02-related.tex: Position the algorithm with respect to related work. Focus on work that has been proven to scale
- 03-design.tex: Present the highlevel design of the distributed solution. Focus on communication (control and data) and synchronization, computational parallelism, DKV Store.
- 04-evaluation.tex: Strong scaling, weak scaling, scaling #K, scale-out vs scale-up, convergence.
- 05-conclusion.tex

### To compile paper
```
$ make plots && make
```

### To clean
```
$ make clean
```
