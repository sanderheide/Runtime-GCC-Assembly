# Mandatory assignment
## x86_64 and MIPS64 assemblies, beat the compiler

Inf-2200 at UiT The Arctic University of Norway.

This is a group assignment, to be done in groups of two. You need to select a partner in your colloquium group.

The design review dates and hand-in times are on the course website.

## Assignment tasks
### Description

In this first assignment, you will compare your assembly coding skills against a compiler's. The C-version of a matrix multiplication benchmark is given. You must: 

1. Implement a matrix multiplication in x86 and MIPS assembly
2. Estimate the theoretical time of both your asm implementations
3. Compare the theoretical time with the execution time for both asm implementations
4. Compare the compiled C code performance with the execution time for both asm implementations. You can try different optimisation flags and compare the results
5. Summarise your work in a report 

### Report

The report must contain all necessary information for an expert to evaluate your design and implementation. You must assume that the expert has read the textbook and the assignment text. You do not need, and should not, repaeat the content in the textbook. The report should be maximum 6 pages and have the following sections:
1. Introduction: description of the benchmark. What does it do? Where is it used?
2. Implementation: describe your assembly implementations of the matrix multiplication.
3. Methodology, where you describe:
   1. How you estimate the theoretical time both for x86 and MIPS versions. 
   2. The computers, emulators, and cross-compiler you used for the experiments (especially if different from the default ones).
   3. How you measured the execution time for the benchmark, including the resolution of your timer. 
   4.	Experiment parameters such as size of matrix, number of iterations, number of repeated experiment executions, etc.
4. Results: where you compare the theoretical time to the measured time of the x86 assembly, MIPS assembly and C versions.
5. Discussion: where you discuss your results and summarize lessons learned.
6. LLM declaration: where you describe how you have used an LLM (or something similar) to help writing your report. You must write this section yourself without the help of an LLM.

### Grading sheet
A grading sheet is given. It contains a checklist with what your work should provide. You can find it in [Grading sheet](./grading_sheet.ods) 

### Deliverables
You will publish your solution in Canvas in the ["Microbenchmark in assembly" assignment](https://uit.instructure.com/courses/42618/assignments/154817). Your solution must contain:
- an archive containing the code implementing your solution (with the same structure as the pre-code)
- a pdf file of your report

# Resources
## MIPS/x86 cross-compilers and emulators 

To compile and execute MIPS64 programs (and x86 programs on ARM Macs), a cross-compiler and emulator are required. You can either choose to install them on your system, or use the docker container provided for the assignment (see **Host setup** and **Docker setup** sections for details).

Once your environment is setup, a Makefile is provided to compile and run the program. The following commands can be called either from the host or the docker container: 
- `make` compiles the program using `gcc` by default
- `make mips64` compiles the program using mips64 cross compiler (`mips64-linux-gnuabi64-gcc` by default)
- `make x86` compiles the program using x86 cross compiler (`x86_64-linux-gnu-gcc` by default)
- `make run` run the program on the host
- `make run_mips64` run the program using the mips64 emulator 
- `make run_x86` run the program using the x86 emulator 

If necessary, you can change the name of the cross-compiler using `CC` variable (`make CC=<new_name>`) and the name of the emulator using `X86_EMU` and `MIPS_EMU`. 

### Host setup
On Ubuntu or WSL2 you can install the dependencies specified on the Dockerfile. On other distributions or Mac systems, you are advised to use the docker container, especially the ARM Macs. You can also search for resources online, but they may be difficult to get through.    

### Docker setup
Requirements: [Docker](https://docs.docker.com/get-docker/)

The Dockerfile is based on Ubuntu 24.04. Running the container gives an environment with both mips64 and x86 cross-compiler and the emulator installed. The environment is available through the command `make docker`. You can compile and run the code as intended when inside the docker environment (using the Makefile). All changes in the src folder on the host are registered in the docker environment. You can use your IDE to edit the code then compile and run it inside the docker environment.

## Useful resources
- [Introduction to Assembly](./Introduction-to-assembly.pdf)
- [x86 register reference](https://www.swansontec.com/sregisters.html)
- [x86-64 cheatsheet](https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf)
- [MIPS Instructions Formats](https://en.wikibooks.org/wiki/MIPS_Assembly/Instruction_Formats)
- [MIPS Instruction Set](https://cscie95.dce.harvard.edu/fall2023/slides/MIPS%20Instruction%20Set.pdf)
- [How branch prediction may affect performance](http://stackoverflow.com/questions/11227809/why-is-processing-a-sorted-array-faster-than-an-unsorted-array)

To go further:
- [Roofline: An Insightful Visual Performance Model for Multicore Architectures](./docs/Roofline-An-Insightful-Visual-Performance-Model-for-Multicore-Architectures.pdf)
- [The Architecture of the Nehalem Processor and Nehalem-EP SMP Platforms](./docs/nehalem.pdf)
- [Performance Analysis Guide for Intel® Core™ i7 Processor and Intel® Xeon™ 5500 processors](./docs/performance_analysis_guide.pdf)


## Possible use of an LLM

You may use an LLM to improve your report, but you are responsible for the content of the report and you need to declare how you use the LLM. It is up to you to find the best use of it. Some of our suggestions are: get structure of an IMRaD report, improve language of sections you have written, suggest bakground material description, and get feedback of your results description.

## Cheating

In **Norwegian:** Som student plikter du å sette deg inn i reglene som gjelder for bruk av hjelpemiddel ved eksamen samt regler for kildebruk og sitering. Ved brudd på disse reglene kan du bli mistenkt for fusk eller forsøk på fusk. Fusk på eksamen og plagiering i skriftlige arbeider innebærer at man bryter med det man kaller akademisk redelighet. Akademisk redelighet dreier seg om å være tydelig i forhold til hvilke tanker og refleksjoner som er ens egne og hvilke som er hentet fra andres arbeider, slik at arbeidet kan etterprøves. Fusk er alvorlig og straffes med annullering av eksamen og/eller utestenging fra universitetet. Bruk tid på å sette deg inn hva som regnes som plagiering eller fusk. Instituttets web-side [Kildebruk, plagiering og fusk på eksamen / obligatoriske oppgaver](https://uit.instructure.com/courses/327/pages/kildebruk-plagiering-og-fusk-pa-eksamen-slash-obligatoriske-oppgaver) er en god start for å lære mer om dette.

In **English**: As a student at UiT, you are obliged to familiarize yourself with the current rules that apply to the use of aids during exams, as well as rules for source use and citation. In the case of violation of these rules, you may be suspected of cheating, or attempt at cheating. Cheating on an exam is considered a violation of academic integrity. Academic integrity(honesty) is about being clear in relation to which thoughts/reflection and work are one's own, and which are taken from other's work. Cheating is punishable by cancellation of exams and/or exclusion from university. You can read more about plagiarism and cheating on: [canvas](https://uit.instructure.com/courses/327/pages/kildebruk-plagiering-og-fusk-pa-eksamen-slash-obligatoriske-oppgaver).
