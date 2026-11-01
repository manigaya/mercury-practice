# How to use this practice project

`README.md` is written like the brief an interviewer would hand you. This file is just for you.

There are two branches:
- **`main`**: the half-built starter. This is what you practice on.
- **`solution`**: one possible finished version. **Don't look until you've done your own attempt.**

---

## One-time setup (about 10 minutes, do this before Friday)

The app loads its data from your own GitHub repo, so it needs to live on GitHub under your account.

1. **Install GitHub Desktop** from desktop.github.com and sign in with your GitHub account (create one at github.com if you need to).
2. **Unzip** `mercury-practice.zip`. Move the `mercury-practice` folder somewhere easy, like your home folder.
3. **Run the setup script.** Open Terminal and run (replace `your-username` with your GitHub username):
   ```bash
   cd ~/mercury-practice
   bash setup.sh your-username
   ```
   This puts your username into `Config.swift` on both branches.
4. **Publish to GitHub.** In GitHub Desktop: File → Add Local Repository → choose the `mercury-practice` folder. Click **Publish repository**, **untick "Keep this code private"** (the app can't read a private repo), and publish.
5. **Publish the solution branch too.** In GitHub Desktop, switch to the `solution` branch with the "Current Branch" dropdown, click **Publish branch**, then switch back to `main`.
6. **Check the data is live.** Open this in your browser (with your username):
   `https://raw.githubusercontent.com/your-username/mercury-practice/main/api/transactions.json`
   You should see the JSON. If you get a 404, wait a couple of minutes and try again.
7. **Delete the folder you unzipped.** On Friday you'll clone it fresh, the way you will in the interview.

---

## Practice session (Friday)

Treat this like the real interview.

### Before you start the timer (simulates the first few minutes of the call)
```bash
cd ~
git clone https://github.com/your-username/mercury-practice.git
cd mercury-practice
open MercuryPractice.xcodeproj
```
In Xcode, pick an iPhone simulator at the top and press **⌘R**. It should build and show "Transactions will go here."

If it doesn't build:
- **Signing error:** click the blue project icon → MercuryPractice target → Signing & Capabilities → Team → your Personal Team
- **"iOS 17.0 is not installed"** or a similar platform error: Xcode → Settings → Components, and install the iOS simulator runtime

### Read before you code (5 minutes)
Read `README.md` and every Swift file. Say out loud what's there and what's missing. Then ask your clarifying questions (write them down if you're practicing alone).

### Build (60-minute timer)
- Do the **core** requirements first, in order. Run the app after each one.
- **Talk the whole time:** what you're doing, why, and what you're unsure about.
- Ask an LLM **small** questions only ("how do I decode ISO 8601 dates with JSONDecoder?"), never "build this screen."
- At 50 minutes, stop adding features. Make sure it runs and write down what you'd do next.

### Test the error state
In `Config.swift`, temporarily change `api` to `apix` in the URL and run. You should see your error screen. Change it back.

### Things that commonly trip people up here
- The JSON is wrapped: `{ "transactions": [...] }`, not a bare array.
- `postedAt` is a string in the JSON but a `Date` in Swift. `JSONDecoder` needs to be told how to read it.
- `note` can be `null`.
- To go to the detail screen, the row needs to be inside a `NavigationLink`.

### Afterwards
1. Commit your work: `git add . && git commit -m "My attempt"`
2. Compare with the solution: `git diff main solution -- MercuryPractice`
   (or switch branches in GitHub Desktop and read the files in Xcode)
3. Don't worry if the solution looks different from yours. There are many right answers. Notice what's different and why.

---

## Prepare for the 30-minute review

Practice answering these out loud:

1. **"Walk me through your code."** Start with the data flow: API → model → view model → views.
2. **"What would you do with another day?"** Unit tests for decoding and the view model, caching, pagination, accessibility (VoiceOver labels, Dynamic Type), better error messages, dark mode check.
3. **"Why `Double` for money? Is that a problem?"** Yes. Floating point can't represent some decimal values exactly (0.1 + 0.2 ≠ 0.3). In production, use `Decimal` or store whole cents as an `Int`. A strong answer for a fintech company.
4. **"Why one `state` enum instead of `isLoading` / `error` / `items`?"** (see the solution) It makes impossible combinations, like loading *and* error at the same time, impossible to represent.
5. **"How would you test this?"** Inject the `APIClient` into the view model so tests can pass in a fake one that returns sample data or throws an error.
6. **"How would you split this across a team?"** Networking and models, the list screen, and the detail screen are independent pieces. Agree on the model first, then work in parallel.
7. **"How would you review this if a junior engineer sent it?"** Your management experience is the advantage here: readability, edge cases, tests, and how you'd give the feedback.

---

## Do it again (Sunday)

Clone it fresh into a different folder and build it again, faster. Try a different look (cards instead of a plain list?) or different stretch goals.
