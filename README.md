# Transactions — iOS Exercise

Welcome! In this exercise you'll build a small SwiftUI app that shows a business bank account's recent transactions.

**Timebox:** 60 minutes. You're not expected to finish everything — we care more about how you approach the problem than how far you get. Please talk us through what you're doing as you go.

**Ground rules:** Feel free to look things up, read docs, or ask an LLM questions. Please don't use AI to generate the whole project.

---

## What's already here

| File | What it is |
|---|---|
| `Models/Transaction.swift` | The `Transaction` model. Not decodable yet. |
| `Models/Transaction+Mock.swift` | Sample transactions for SwiftUI previews |
| `Networking/APIClient.swift` | Where the network calls go. Currently a stub. |
| `Views/TransactionListView.swift` | The first screen. Currently a placeholder. |
| `Views/TransactionDetailView.swift` | The detail screen. Currently a placeholder. |
| `Config.swift` | The API's base URL |

## The API

**`GET {baseURL}/transactions.json`**

```json
{
  "transactions": [
    {
      "id": "txn_001",
      "counterpartyName": "Stripe",
      "amount": 12450.0,
      "postedAt": "2026-10-31T16:05:00Z",
      "status": "pending",
      "method": "ACH",
      "category": "Revenue",
      "note": "Weekly payout"
    }
  ]
}
```

- `amount` — positive means money coming in, negative means money going out
- `status` — one of `posted`, `pending`, `failed`
- `note` — may be `null`

**`GET {baseURL}/account.json`** *(stretch goals only)*

```json
{
  "id": "acct_4521",
  "name": "Mercury Checking ••4521",
  "availableBalance": 284530.12,
  "currentBalance": 271839.39
}
```

---

## Requirements

### Core

1. **Fetch and list transactions.** Load transactions from the API and show them in a list, newest first.
2. **Rows.** Each row shows the counterparty name, the date, and the amount formatted as US dollars (e.g. `−$1,240.18`). Money coming in should be green with a `+` sign.
3. **Loading and errors.** Show a loading indicator while fetching. If the request fails, show an error message with a way to retry.
4. **Detail screen.** Tapping a row opens a detail screen that shows the amount (large), counterparty, status, date and time, method, category, and the note if there is one.

### Stretch (pick any)

5. Pending transactions are visually distinct in the list (for example, a "Pending" badge). Failed transactions too.
6. Pull to refresh.
7. A header above the list showing the account name and available balance from `account.json`.
8. Group transactions into sections by day.
9. Search transactions by counterparty name.

### Rough sketch

```
┌──────────────────────────────────┐     ┌──────────────────────────────────┐
│ Transactions                     │     │ < Transactions                   │
│                                  │     │                                  │
│  Mercury Checking ••4521         │     │               (S)                │
│  $284,530.12                     │     │          +$12,450.00             │
│                                  │     │             Stripe               │
│  (S) Stripe          +$12,450.00 │ ──▶ │           [ Pending ]            │
│      Oct 31  [Pending]           │     │                                  │
│  (A) Amazon Web S...  −$1,240.18 │     │  Date      Oct 31, 2026, 9:05 AM │
│      Oct 31  [Pending]           │     │  Method                      ACH │
│  (G) Gusto Payroll   −$48,210.55 │     │  Category                Revenue │
│      Oct 30                      │     │                                  │
│  ...                             │     │  Note                            │
│                                  │     │  Weekly payout                   │
└──────────────────────────────────┘     └──────────────────────────────────┘
```

This is a guide, not a pixel-perfect spec. Use your judgment.

---

Good luck, and have fun!
