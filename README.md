# Countable Coin – Proof of Concept

This repository provides a proof-of-concept implementation of Countable Coin, a semantic transaction layer for blockchain-based financial transfers.

The goal of this prototype is to demonstrate how structured semantic data can be attached to token transfers so that enterprise systems can interpret the accounting meaning of blockchain transactions.

This implementation is related to the research concept described in the paper:

"Countable Coin: A Semantic Layer for Blockchain Transactions"

------------------------------------------------------------

Motivation

Traditional blockchain token transfers represent the movement of assets but do not explicitly encode the accounting meaning of a transaction.

In enterprise environments, financial transactions typically include contextual information such as:

- department code
- business purpose
- transaction reference (for example, invoice ID)

However, these semantics are usually stored off-chain in ERP or accounting systems and are not directly represented in blockchain transactions.

Countable Coin introduces a semantic transaction layer that attaches structured metadata to token transfers.

This enables enterprise systems to interpret blockchain transactions within existing financial workflows.

------------------------------------------------------------

Smart Contract Overview

The smart contract extends standard ERC-20 token transfers by introducing a function that includes semantic metadata.

Semantic fields used in this prototype:

deptCode  : department identifier  
purposeCode : business purpose of the transaction  
refId : reference identifier (for example, invoice ID)

These fields provide contextual information about the financial meaning of a transaction.

------------------------------------------------------------

Semantic Transaction

The smart contract provides the function:

transferWithCountableData(...)

This function performs a token transfer while attaching semantic metadata.

Example semantic transaction:

deptCode: D001  
purposeCode: P001  
refId: INV-2026-001

------------------------------------------------------------

Event for Enterprise Integration

The contract emits the event:

CountableTransfer(...)

This event contains both token transfer data and semantic metadata.

Enterprise systems such as ERP, accounting, or auditing platforms can listen to this event to interpret the accounting meaning of a blockchain transaction.

------------------------------------------------------------

Prototype Scope

This repository contains a research prototype intended to demonstrate the semantic transaction concept.

It is not designed as a production financial system but as a minimal implementation illustrating how semantic data can be embedded in blockchain transfers.

------------------------------------------------------------

License

This project is released under the MIT License.
