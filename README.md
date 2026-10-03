# Redflix — Automated Viewing Plans in PDDL

Build a viewing schedule that respects narrative dependencies, related content and daily limits. This project translates a movie catalog into a **symbolic planning problem**, with five progressively richer PDDL domains and a reproducible instance generator.

University team project · **ABIA, Artificial Intelligence degree, FIB–UPC**.

## Modeling approach

Typed objects represent content, narrative universes and days. Predicates describe predecessor relationships, parallel content, desired items and assigned days. Numeric fluents track remaining content and daily usage. Actions add required content to the plan and assign it to a day when the domain constraints hold.

| Extension | Domain file | Added modeling capability |
| --- | --- | --- |
| 0 | `domains/base_dom.pddl` | Basic catalog and viewing-plan assignment |
| 1 | `domains/1_dom.pddl` | Narrative predecessor chains within universes |
| 2 | `domains/2_dom.pddl` | Parallel-content relationships and relative-day constraints |
| 3 | `domains/3_dom.pddl` | Daily item counts and occupied preceding days |
| 4 | `domains/4_dom.pddl` | Content duration and a 200-minute daily budget |

Extension 3 permits **three items per day**: its action checks the current count is at most two before incrementing it. Extension 4 replaces that capacity condition with the duration budget; generated durations range from 50 to 100 minutes. Parallel-content conditions differ between domains and should be interpreted from the chosen domain file.

## Generate and solve an instance

Python 3.10+ is sufficient for generation:

```sh
python generate.py --movies 12 --extension 4 --seed 42 --output problem_redflix.pddl
python -m unittest discover -s tests -v
```

Use a planner supporting typed ADL and numeric fluents, such as the Metric-FF setup used for the original experiments. With a compatible executable named `ff`, the invocation is:

```sh
ff -o domains/4_dom.pddl -f problem_redflix.pddl
```

Planner installation is external to this repository. Match the domain and generated extension. The generator uses a local random seed, produces deterministic ordering and handles one- and two-movie catalogs. Parallel pairs are generated across universes so they do not duplicate a predecessor chain.

## Evidence and outputs

The repository preserves **16 original PDDL files** and an academic log containing 11 planner outputs in [archive/recoleccion_outputs.txt](archive/recoleccion_outputs.txt). The log demonstrates the original planning experiments; its timings are not a controlled benchmark across matched scenarios.

The portfolio checks cover invalid arguments, small catalogs, byte-identical seeded generation and preservation of the global random state. Seeded examples for all five extensions are in `examples/`. Their balanced parentheses and required problem sections were checked. A planner was not available for this publication pass, so newly generated examples have not been independently solved or validated by a planner.

There is no explicit minimization metric in these domains. A successful plan satisfies the model; it does not establish a globally shortest or otherwise optimal schedule.

## Repository guide

- `domains/`: working domains with explicit typing, ADL and numeric-fluent requirements.
- `generate.py`: configurable seeded problem generator.
- `examples/`: generated 12-movie instances, seed 42.
- `archive/`: unchanged recovered domains, problems, generator and planner log.
- `tests/`: generator regression checks.

## Credits and source

Team repository contributors: **daniupc, AndreuLopezz and joelalfaroupc**. Source: [daniupc/redflix](https://github.com/daniupc/redflix), which may require access; recovered revision `066abf2b40bd7c78ed0f46197acdb92f0876e5ba`. The original project report was not recovered and is not included. See [PROVENANCE.md](PROVENANCE.md).
