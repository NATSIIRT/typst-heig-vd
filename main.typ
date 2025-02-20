#import "@local/heig-vd:1.0.0": project

#show: project.with(
  title: "Create and investigate the security of a new cryptographic algorithm",
  subtitle: "Travail de Bachelor",
  authors: (
    "Tristan Baud",
    "John Doe",
  ),
  assistants: (
    "Jane Doe (External)",
    "Dr. Bob Wilson",
    "Dr. Alice Brown",
    "Dr. Eve Green",
  ),
  professors: (
    "Pr. John Smith",
    "Pr. Maria Garcia",
  ),
  department: "Département des Technologie de l'information et de la communication (TIC)",
  sector: "Filière Télécommunications",
  orientation: "Orientation Sécurité de l'information",
  branch: "Cryptography and Security",
  academic-year: "2025-2026",
  chapter-pagebreak: false,
)

= Abstract
This bachelor thesis presents the development and security analysis of a novel cryptographic algorithm. The work includes both theoretical foundations and practical implementation aspects, with a focus on resistance against modern cryptographic attacks @stinson2018cryptography.

= Introduction
The field of cryptography continues to evolve with the advent of quantum computing and increasing computational power @quantum2023threat. Modern security systems require robust cryptographic algorithms that can withstand both classical and quantum attacks.

== State of Current Research
Recent developments in cryptography have shown that traditional algorithms might be vulnerable to quantum computing @post2023quantum. This has led to increased research in:

- Post-quantum cryptography @nist2024standards
- Side-channel attack resistance @side2022channels
- Performance optimization in resource-constrained environments

== Methodology Overview
Our research methodology follows the standard cryptographic evaluation process @rogaway2011evaluation, including:

#table(
  columns: (auto, auto),
  [Phase], [Description],
  [Analysis], [Theoretical security evaluation],
  [Implementation], [Prototype development],
  [Testing], [Security and performance testing],
  [Validation], [Peer review and verification],
)

= Technical Background
== Basic Concepts
The fundamental concepts of modern cryptography @stinson2018cryptography include:

#table(
  columns: (auto, auto, auto),
  [Concept], [Description], [Relevance],
  [Confusion], [Complex key-ciphertext relationship], [High],
  [Diffusion], [Input bit changes affect many output bits], [High],
  [Key Space], [Set of all possible keys], [Critical],
)

== Advanced Topics
Building on established algorithms like AES @nist2001aes and ChaCha20 @bernstein2012chacha, we explore:

1. New block cipher designs
2. Improved key scheduling
3. Enhanced diffusion mechanisms

= Implementation
The implementation phase focused on creating a secure and efficient algorithm @bellare2000security with:

- Strong security guarantees
- Efficient software implementation
- Resistance to side-channel attacks
- Quantum-resistant properties

= Results
Our analysis compared several key metrics:

#table(
  columns: (auto, auto, auto, auto),
  [Algorithm], [Security Level], [Performance], [Memory Usage],
  [Our Proposal], [Very High], [Good], [Medium],
  [AES-256], [High], [Excellent], [Low],
  [ChaCha20], [High], [Good], [Low],
)

= Future Work
Future research directions include:

1. Extended security analysis against:
   - Quantum attacks @post2023quantum
   - Side-channel vulnerabilities @side2022channels
   - Novel cryptanalysis techniques

2. Performance optimizations for:
   - Hardware implementation
   - Resource-constrained devices
   - High-throughput applications

= Conclusion
The proposed algorithm shows promising results in terms of security and performance, particularly in addressing future quantum computing threats @quantum2023threat.

#bibliography("references.bib")