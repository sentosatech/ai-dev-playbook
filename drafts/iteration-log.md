# Iteration Log

This draft records what we learn while applying the AI Dev Playbook to real
repos. It is intentionally a working log, not official guidance.

The goal is to evolve the playbook by stepping through real cases one move at a
time, then promoting only the ideas that prove useful.

## Tenet

Freedom within structure.

The playbook should create enough shared structure that consistency, quality,
and eventual agent autonomy become likely. It should not turn engineering work
into a rigid checklist or remove human engineering judgment.

Good structure should:

- make project truth easy to find
- separate brainstorming, drafts, approved decisions, and implementation
  contracts
- distinguish durable documentation from working material
- help engineers understand the system before they work on it
- help agents understand what is safe to do autonomously
- make approval boundaries clear
- keep architecture control with the responsible engineer or architect
- preserve room for engineers to think, revise, and choose better approaches

Good structure should not:

- force every task through the same formal sequence
- treat hints or checkpoint files as workflow engines
- pretend product, architecture, requirements, and implementation always happen
  in clean sequential phases
- turn brainstorming into approved truth
- let models silently make or drift architecture decisions
- create empty docs or folders just to satisfy a template
- tie engineers' hands when judgment matters

## Working Method

Use real project adoption as the feedback loop:

1. Try the playbook on a real repo.
2. Notice friction, ambiguity, or overreach.
3. Adjust the skill, doc, or structure.
4. Keep changes small.
5. Record the learning here.
6. Promote only stable lessons into playbooks, templates, or skills.

This is deliberately not a Big Bang design process.

## Process Fluidity

The phases are guidance, not a rigid sequence.

Some work may move roughly from product brief to architecture to specs to
implementation. Other work may loop back as understanding improves. A product
brief and first architecture pass may happen together. A spec may reveal a
missing product question. An implementation slice may expose an architecture
tradeoff that needs to be revisited.

The playbook should support this natural engineering motion instead of hiding
it.

Use process structure to:

- make the current focus visible
- maintain a visible question queue
- preserve open questions between sessions
- record when a decision becomes durable
- separate draft thinking from approved truth
- help humans and agents resume work safely
- improve consistency and quality

Do not use process structure to:

- force a good engineer into artificial ceremony
- require every project to pass through identical phases
- prevent productive looping when new information appears
- make AI development feel like filling out forms

The goal is guidance and structure that enables great engineering and
consistent outcomes, not a process that ties engineers' hands.

## Layered Thinking Is Nonlinear

Human-AI engineering sessions should not be expected to stay at one level of
abstraction.

An engineer may move naturally between product brief, requirements,
architecture, specs, implementation, verification, and operational concerns in
the same session. That movement is often productive. Architecture discussion
may expose implementation constraints. Implementation exploration may reveal a
missing requirement. A tool contract may force an architecture decision. A
verification failure may uncover ambiguity in the product brief.

The playbook should support this motion instead of forcing every session into a
single narrow lane.

Use the documentation structure as a way to land insights in the right place:

- product intent and outcomes belong in the product brief or PRD
- durable architecture choices belong in architecture docs or ADRs
- stable behavior contracts belong in specs
- implementation details belong in code, tests, and focused implementation docs
- unresolved issues belong in the active question queue or draft docs

The work does not have to happen in that order. The requirement is that, before
decisions are treated as settled or work is handed off to more autonomous AI
execution, the relevant durable artifacts are updated and consistent.

## Cross-Layer Documentation Impact

Important decisions often affect more than the document where they first
appear.

When the engineer approves a meaningful decision at any level, the AI should
check whether the decision changes related artifacts at other levels:

- product brief or PRD
- architecture text or diagrams
- ADRs
- implementation decision docs
- specs and schemas
- README navigation
- project context or status hints
- verification expectations
- code conventions or tests

The AI should not blindly update every document. It should make a quick
cross-layer impact pass, update the artifacts that are genuinely affected, and
leave unrelated docs alone. This keeps project truth consistent without turning
the process into ceremony.

## Front-Loaded Investment Enables Later Autonomy

The early phases of an AI-assisted project should receive substantial human
engineering attention.

The responsible engineer should invest in shaping requirements, architecture,
implementation boundaries, verification, conventions, and the first meaningful
code paths. This is not paperwork for its own sake. It is how the project
creates enough shared truth for later AI work to be reliable.

Once the product intent, architecture, contracts, repo conventions, test
patterns, and initial implementation shape are established, future LLM sessions
can operate with much more independence. The model has real project structure
to follow instead of inventing direction from a prompt.

The payoff model is:

```text
invest significantly up front
  -> establish durable project truth and working conventions
  -> enable safer, faster, more autonomous AI execution later
```

The goal is not to remove the engineer from the work. The goal is to let the
engineer concentrate on the decisions that matter most while giving the AI a
stable structure for increasingly independent execution.

## Iteration Is How Engineers Learn

Iteration is not just a delivery technique. It is how engineers discover the
details that make requirements, architecture, contracts, and implementation
real.

Early product and architecture work should be thoughtful, but it should not
pretend that every important detail can be known up front. Small proving
slices, prototypes, implementation passes, and verification attempts expose
missing requirements, unclear boundaries, awkward interfaces, hidden
dependencies, and architecture decisions that need to be revisited.

The playbook should therefore encourage iterative proof:

- choose a small slice that exercises the intended structure
- implement enough to learn from real behavior
- use AI aggressively for research, scaffolding, implementation, and review
- preserve human control over the decisions that the iteration reveals
- update product, architecture, specs, ADRs, or verification docs when the
  iteration changes project truth

Iteration should not be treated as drift away from the plan. Done well, it is
how the plan becomes accurate.

## Slices And Layers

Use layers to keep project truth organized, and slices to keep design and
implementation work focused.

Layers are the levels of thinking: product brief, requirements, architecture,
implementation decisions, specs, code, tests, and operations. They help the AI
and engineer land each insight in the right place.

Slices are bounded pieces of behavior that exercise the structure. A good slice
is small enough to reason about and implement, but meaningful enough to test the
architecture. For example, `transcribe-audio` can prove CLI input, typed
requests, capability boundaries, output layout, status metadata, and
verification without forcing YouTube search, download, summaries, detached job
runners, JSON-RPC, or MCP into the first pass.

Architecture discussions can focus on a slice while still keeping the broader
architecture in view. Future layers and slices should be recorded when they are
known, but they do not all need to be resolved before the first useful slice is
built.

This keeps the process practical:

- choose a slice that proves important structure
- discuss only the architecture needed for that slice plus obvious future
  pressure points
- record future architecture topics without letting them expand current scope
- implement and verify the slice
- use what was learned to refine the next layer or slice

## Foundation-First Layer Model

The current layer model is emerging as a foundation-first process:

```text
exploration and prior art
  -> product intent and outcomes
  -> architecture and system model
  -> implementation decisions and conventions
  -> specs and contracts
  -> proving-slice plan
  -> build, verify, and close
  -> project memory and durable truth updates
```

These layers are not a waterfall. They are places to land different kinds of
engineering truth while the human and AI move naturally through the work. A
session may move between product, architecture, implementation decisions,
contracts, verification, and code as understanding improves.

The purpose of the foundation layers is to let a strong engineer establish
enough durable truth that later spec-driven execution has something reliable to
execute against. Once product intent, architecture, implementation conventions,
contracts, verification, and a first proving slice are stable enough, more
formal spec-driven loops can safely take over more of the planning, tasking, and
implementation work.

Draft diagram source: `docs/stc-ai-playbook.excalidraw`.

## Planning As A Bridge

Planning is a real layer in the process, but it should stay lightweight.

After the product brief, architecture, and implementation decisions are
sufficient for the current slice, the AI and engineer should create a small
execution plan before coding. The plan connects the durable thinking to the
next concrete implementation pass.

A good plan should:

- name the selected slice
- define the smallest useful outcome
- build from the lowest stable layer outward
- identify what is in scope and explicitly out of scope
- state the verification proof needed for the pass
- note which docs may need updates if the pass changes project truth

Planning should not become a heavyweight project-management ritual. Its job is
to prevent scope drift, keep the next pass reviewable, and make the first proof
of life intentional.

## Reference Implementations As Input

Before starting a serious implementation pass, the AI should ask whether there
is an existing reference implementation, prototype, spike, script, or previous
attempt that can inform the work.

A reference implementation can be valuable even when it is throwaway. It may
contain hard-won details about library behavior, runtime setup, edge cases,
file formats, failure modes, performance, or workflow shape. Those details can
save time and prevent repeating known mistakes.

Reference implementations are informative, not authoritative. The project
brief, architecture, implementation decisions, specs, and human-approved
requirements remain the source of truth. The AI should use the reference to
extract lessons and candidate details, then fit them into the current project
structure instead of copying the old design blindly.

Recommended pre-build prompt:

```text
Is there a reference implementation, prototype, script, or prior attempt that
should inform this slice? If yes, where is it, and which parts are useful or
known to be problematic?
```

When a reference exists, the AI should inspect it before coding and report:

- reusable ideas or patterns
- pitfalls or bugs already discovered
- runtime or dependency lessons
- file format or artifact details
- differences from the current approved architecture
- what should be copied, adapted, ignored, or explicitly avoided

## Implementation Decisions Layer

Implementation decisions are a useful layer between architecture and code.

Architecture should define system shape, ownership boundaries, durable flows,
and key constraints. Implementation decisions capture how the first real slices
will actually realize that architecture: module boundaries, call paths,
libraries, packaging, runtime choices, error handling patterns, test strategy,
file naming, and other practical choices that are too concrete for architecture
but too important to leave implicit in code.

This layer is still nonlinear. Implementation decisions may reveal architecture
issues. Architecture decisions may force implementation choices. First code
paths may expose missing requirements or contract details. The playbook should
let engineers move between these layers naturally while keeping the artifacts
clear.

Examples of implementation decisions:

- Should a CLI call Python capabilities directly or call through an RPC service?
- Which package layout should prove the first capability?
- Which library should own transcription?
- How should typed request/result objects be represented?
- What fixtures and smoke tests should prove the first slice?
- Which runtime environment owns heavy dependencies, and how much of that
  burden should clients carry?

Implementation decisions should start as draft working material. Durable
outcomes can later be promoted into architecture docs, ADRs, specs, code
conventions, or verification docs.

## Interactive Exploration Before Question Lists

Human-AI sessions should be allowed to unfold as interactive exploration, not
only as a prewritten list of questions.

Some obvious questions may be useful at the start of a session, but many of the
important questions emerge only after the engineer and AI discuss the problem,
compare options, look at examples, reason through tradeoffs, or try a small
implementation slice. Forcing every session into a bullet list of questions too
early can flatten the natural thinking process.

The playbook should encourage a rhythm like this:

```text
explore the topic
  -> notice decisions, risks, or ambiguities
  -> capture them as questions when useful
  -> resolve or defer them
  -> update the right durable or working artifact
```

The question queue is a capture mechanism, not the conversation itself. It
should preserve important threads without replacing the engineer's natural
process of reasoning, reframing, and deciding.

## Question Queue

Use a visible question queue during human-AI sessions, but do not treat it as
the only valid shape of the session.

The AI may seed the queue with likely decisions, ambiguities, risks, and
follow-up questions based on the current docs and repo evidence. As discussion
progresses, the human and AI can add, remove, reorder, or reframe questions.

The queue is useful because it:

- keeps open decisions visible without interrupting the current thread
- lets the human steer architecture and product thinking naturally
- helps future sessions resume the reasoning path
- prevents important concerns from being lost while preserving flow

The queue should remain lightweight. It is not a gate, checklist, or formal
project-management database. It should not turn an exploratory engineering
session into a form-filling exercise.

Good queue items are specific enough to revisit:

- Must client and capability code assume access to the same local filesystem?
- Which interface should prove the architecture first?
- Should tools accept CLI-style args, option dictionaries, or typed requests?

Record durable answers in the appropriate artifact: product brief,
architecture, ADR, spec, or project context.

## Open Questions As Resume Hints

Durable and draft docs should preserve important open questions so future
human-AI sessions can resume the work without reconstructing the whole thread.

For architecture work:

- keep active questions in `docs/drafts/architecture.md` while architecture is
  being shaped
- keep remaining open architecture questions in `docs/architecture.md` after
  promotion
- use `PROJECT_CONTEXT.md` as a short pointer to the current question set
- use `.ai/project-state.yaml` only as a lightweight checkpoint

ADRs should generally record resolved architecture decisions. They can mention
narrow follow-ups for that decision, but they should not become the main
question queue.

If the architecture doc has no open architecture questions, treat that as a
hint that the architecture is sufficient for now. It does not mean the
architecture is permanently complete or should never be revisited.

Open questions should be resolved by updating the relevant durable artifact:
architecture text, ADR, spec, product brief, or project context.

## Durable And Working Documentation

Distinguish docs that must stay current from docs that are temporary, historical,
or exploratory.

Working documentation captures thinking while it is still forming. It may be
messy, incomplete, contradictory, or eventually discarded. Examples:

- `docs/brainstorming/`
- `docs/drafts/`
- session notes or scratch notes

Durable documentation is project truth. It should be maintained as development
changes the repo. Examples:

- `README.md`
- `docs/product-brief.md`
- `docs/architecture.md`
- `docs/adr/`
- `specs/`
- `PROJECT_CONTEXT.md`
- `AGENTS.md`
- `scripts/verify`

The maintenance rule:

If a change alters product capabilities, tool names, workflows, architecture,
contracts, verification, or operating rules, update the relevant durable docs in
the same change.

Working docs can become stale once their useful ideas are promoted. Durable docs
should not silently drift.

## Local Scratch Space

Each repo should have a root `scratch/` directory ignored by git.

Use it for proof-of-life runs, temporary outputs, local experiments, downloaded
samples, generated artifacts, and agent working files that should not become
project truth. This gives humans and agents a safe, obvious place to try things
without polluting the repo or accidentally committing bulky/transient files.

Recommended convention:

```text
scratch/
```

`.gitignore` should ignore the directory:

```gitignore
scratch/
```

Scratch is working space, not durable documentation. If something discovered in
scratch matters, promote the learning into the appropriate durable artifact:
README, product brief, architecture, ADR, spec, project context, tests, or code.

## README As Front Door

Use `README.md` as the repo front door.

The README should give a short project description and point humans and models
to durable project docs that exist. It should not duplicate the product brief,
architecture, specs, or process docs.

Recommended links when present:

- product brief: `docs/product-brief.md`
- product requirements: `docs/product-requirements.md`
- architecture: `docs/architecture.md`
- architecture diagrams: `docs/diagrams/`
- ADRs: `docs/adr/`
- specs: `specs/`
- project context: `PROJECT_CONTEXT.md`
- agent instructions: `AGENTS.md`
- verification command or `scripts/verify`

Maintenance rule:

When promoting durable docs or adding/removing key diagrams, specs, or
verification paths, update README navigation if the repo has a README.

The README should be useful to a human opening the repo and to an LLM trying to
find the right project truth quickly.

## Product Brief And PRD

Treat the product brief and PRD as related but distinct artifacts.

`docs/product-brief.md` is the lightweight durable human guide. It explains what
the product or repo is, who it serves, what outcomes matter, what capabilities
exist, and what is in or out of scope at a high level.

`docs/product-requirements.md` is optional. Add it when product behavior needs
more detail than the brief can cleanly carry, such as user stories, workflows,
acceptance criteria, edge cases, release scope, UX expectations, dependencies,
or risks.

Default flow:

```text
docs/brainstorming/initial-thinking.md
  -> docs/drafts/product-brief.md
  -> docs/product-brief.md
  -> docs/product-requirements.md   # only if needed
  -> docs/architecture.md
  -> specs/
```

Every project benefits from a product brief. A PRD should earn its place.

## Documentation Audiences

Experiment with documentation that serves both humans and models without
assuming the final shape too early.

Human-facing documentation should be clear, concise, and high level. It should
use diagrams, descriptions, and system narratives that let engineers understand
what the system is, how it works, and why it is shaped that way.

The goal is not just to help agents write code. The goal is to avoid engineers
working on code and systems they do not understand.

Model-facing documentation may need more explicit structure, contracts,
schemas, decision records, invariants, and implementation constraints. That
extra detail should improve agent reliability without making human docs noisy or
overly mechanical.

Open experiment:

- same document with clear human/model sections
- separate paired documents, such as `architecture.md` and
  `architecture-for-models.md`
- human docs plus precise `specs/` artifacts for model execution

Current bias: keep human docs clean and high-signal, then add separate
model-oriented specs or companion docs only when real agent work proves the
need.

As projects move from product brief into architecture, encourage developers to
work with the AI to create a human-facing Excalidraw architecture diagram. The
diagram should help engineers understand the system at a glance before they are
expected to change it. It is not a replacement for architecture text, ADRs, or
specs; it is a comprehension aid for humans.

## LLM-Drafted And Maintained Diagrams

Use the LLM to create first-pass Excalidraw diagrams when the architecture or
system shape is clear enough to visualize.

The first pass does not need to be perfect. Its value is that it gives the
engineer a concrete, editable foundation: boxes, layers, flows, boundaries, and
highlighted proving slices that can be reviewed and refined. This can turn
abstract architecture discussion into a shared visual artifact quickly.

Good first-pass diagrams should:

- stay human-facing and easy to scan
- show system shape, boundaries, and important flows
- highlight the first proving slice when one exists
- avoid trying to capture every implementation detail
- remain editable source, such as `.excalidraw`, not just exported images
- be treated as draft until the engineer reviews and adjusts them

If a diagram becomes part of durable project understanding, link it from the
README and keep it aligned with architecture decisions as they change.

The LLM should also help maintain the diagram incrementally as the discussion
evolves. When an architecture or implementation decision changes the system
shape, output flow, ownership boundary, runtime boundary, or first proving
slice, the AI should consider whether the diagram needs a small update in the
same session.

Incremental diagram updates are valuable because they:

- keep the engineer's mental model current
- make architecture evolution visible instead of buried in prose
- expose inconsistencies between text and system shape
- give the engineer a concrete artifact to critique
- help future sessions resume the design without reconstructing the whole
  conversation

The model should not treat diagrams as authoritative by themselves. The diagram
should reflect the approved or draft decisions in the docs. When the diagram
and text disagree, surface the disagreement and let the engineer decide which
truth should change.

## Architecture Control

As a system grows, new architecture decisions will naturally be needed. Those
decisions should be driven by the responsible engineer or architect.

Models can inform, advise, compare options, surface tradeoffs, draft ADRs, and
test assumptions. They should not silently choose architecture, redefine
boundaries, or let implementation momentum turn into unreviewed design.

A software architect or developer should not lose control of the architecture
during AI development.

The playbook should therefore make architecture decision points visible:

- what decision is being made
- what options and tradeoffs exist
- what the model recommends and why
- what the engineer approved
- where the decision is recorded

The goal is not to slow engineering down. The goal is to keep architectural
intent explicit as AI accelerates implementation.

## 2026-06-28 - Media Processing Adoption

Repo under test: `/Users/steve/Documents/code/media-processing`

### What Happened

- We initialized the repo with minimal AI development scaffolding:
  `AGENTS.md`, `PROJECT_CONTEXT.md`, `process.md`, and
  `.ai/project-state.yaml`.
- We moved early project thinking into
  `docs/brainstorming/initial-thinking.md`.
- We added `docs/change-log.md` once there was meaningful project history to
  record.
- We did not create empty `docs/drafts/`, `docs/adr/`,
  `docs/product-requirements.md`, `docs/architecture.md`, `specs/`, `src/`, or
  `tests/` folders.

### Lessons

- Repo init should install rails, not drive the project.
- Process phases should be treated as flexible guidance. Product brief,
  architecture, specs, and implementation may overlap or loop as understanding
  improves.
- Human-AI engineering sessions may move across multiple abstraction levels in
  one conversation. That is normal engineering thinking; the playbook should
  help land each insight in the right durable or working artifact rather than
  forcing a single-session focus.
- Substantial early engineering investment in requirements, architecture,
  implementation boundaries, conventions, verification, and first code paths is
  a leverage move. Once those are established, later LLM work can become much
  more autonomous without inventing project direction.
- Iterative proof is part of engineering learning. Small implementation slices
  and verification attempts should be used to discover missing requirements,
  architecture issues, and contract details, then feed those discoveries back
  into the durable docs.
- Slices and layers are both useful. Layers keep product, architecture,
  implementation, specs, and verification organized; slices keep current design
  and implementation work bounded enough to build and learn from.
- Planning is the bridge between settled-enough direction and a coding pass.
  It should name the slice, bound the work, build from the lowest stable layer
  outward, define the proof of life, and stay light enough not to become
  ceremony.
- Before starting a serious implementation pass, ask whether there is a
  reference implementation, prototype, script, or prior attempt. Treat it as
  informative input, not authoritative project truth.
- When a meaningful decision is made, the AI should check for cross-layer
  documentation impact and update related docs, diagrams, specs, context, or
  verification expectations that genuinely changed.
- Implementation decisions are a distinct useful layer between architecture and
  code. They capture practical choices for the first real slices without
  overloading architecture docs or leaving important decisions implicit in code.
- Runtime ownership and dependency burden are first-class implementation
  concerns. A direct first slice may be useful for learning, while a later
  service boundary may be needed so clients do not inherit heavy local runtime
  setup.
- Sessions should favor interactive exploration over a prewritten laundry list
  of questions. The question queue is useful for capturing threads that emerge,
  but it should not become the driver of the whole conversation.
- Maintaining a question queue during human-AI sessions helps preserve open
  concerns while allowing the conversation to move naturally.
- Open questions in architecture docs are useful resume hints across sessions.
  No open questions means "sufficient for now," not "permanently complete."
- Product briefs, architecture docs, specs, ADRs, and verification docs are
  durable once promoted. They should be maintained as related code and
  capabilities change.
- A root ignored `scratch/` directory is a useful standard convention for
  proof-of-life runs, local experiments, generated outputs, and agent working
  files that should not become project truth.
- README should act as the repo front door, linking to durable docs and current
  diagrams without duplicating their content.
- Product briefs are lightweight default product docs. PRDs are optional and
  should be added only when product behavior needs more detailed requirements.
- Brainstorming must be explicitly marked as unpromoted material.
- `.ai/project-state.yaml` is useful as a hint, but it should not become a
  mandatory state machine.
- Human-facing docs must help engineers understand the system before changing
  it. Model-facing docs may need more explicit structure, but should not make
  human docs harder to read.
- Excalidraw architecture diagrams are a promising human-facing artifact for
  helping engineers understand system shape before implementation.
- LLM-created first-pass Excalidraw diagrams can provide a strong editable
  foundation for human review. The diagram should be treated as draft, but it
  can dramatically accelerate shared understanding when the architecture shape
  has emerged.
- Incrementally updating the diagram as architecture and implementation
  decisions evolve helps the engineer think clearly about system evolution and
  keeps visual understanding aligned with the docs.
- Architecture decisions should remain engineer-driven. Models may advise and
  draft options, but should not silently decide architecture through
  implementation.
- Status reporting is valuable as a read-only skill: inspect evidence, explain
  what is done, show what is pending, and suggest the next human-AI session.
- ADR means Architecture Decision Record. ADRs are useful when an architecture
  decision is durable enough to preserve, not as mandatory paperwork.

### Emerging Structure

The project docs lifecycle currently looks like this:

```text
docs/
  brainstorming/
    initial-thinking.md
  drafts/
  product-requirements.md
  architecture.md
  adr/
  change-log.md
```

Use the structure progressively. Create official docs and folders when there is
real content to put there.

### Open Questions

- Should `docs/drafts/` be a standard recommendation, or just an optional
  convention when draft work becomes active?
- Should the playbook prefer `docs/product-requirements.md`, `docs/prd.md`, or
  a lighter `docs/project-brief.md` for early projects?
- How much of the docs lifecycle should `stc-init-repo` mention versus leaving
  it to `stc-status` and later process skills?
- What is the smallest next process skill that helps promote brainstorming into
  durable docs without becoming prescriptive?
- Should human-facing and model-facing documentation live in separate files, or
  in clearly marked sections of the same file?
