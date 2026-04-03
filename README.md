# Undercover: Pass-and-Play Party Game MVP

I Focused on the Logic and MVP implementations, Making it Pretty should be the next step, down bellow are the screenhsots of the app.

## 📸 Screenshots

<details>
<summary><b>1. Player Setup Screen</b></summary>
<br>
<img width="531" height="954" alt="fisofi_1" src="https://github.com/user-attachments/assets/32a26b7d-6b53-40a7-95a0-6a4834cd36c5" />
</details>

<details>
<summary><b>2. Role Reveal Phase (Hidden)</b></summary>
<br>
<img width="535" height="953" alt="Fisofi_2" src="https://github.com/user-attachments/assets/cb558da7-c55e-4066-9ab4-c68ef8c09cc1" />
</details>

<details>
<summary><b>3. Role Reveal Phase (Revealed)</b></summary>
<br>
<img width="530" height="954" alt="Fisofi_3" src="https://github.com/user-attachments/assets/26fa7bf7-fde5-4928-b733-cfac89b0fd05" />
</details>

<details>
<summary><b>4. Discussion & Voting Screen</b></summary>
<br>
<img width="532" height="955" alt="Fisofi_4" src="https://github.com/user-attachments/assets/1b11dbd5-2011-4a33-9739-51b2dcab32fc" />
</details>

<details>
<summary><b>5. Casting Votes</b></summary>
<br>
<img width="531" height="955" alt="Fisofi_5" src="https://github.com/user-attachments/assets/dbe8ad07-da62-4437-9ae2-1c72c6ec2f4d" />
</details>

<details>
<summary><b>6. Elimination Results</b></summary>
<br>
<img width="529" height="952" alt="Fisofi_6" src="https://github.com/user-attachments/assets/f7b736cf-1a1a-48f9-a032-80ad833080dc" />
</details>

<details>
<summary><b>7. Game Over / Win Condition</b></summary>
<br>
<img width="532" height="954" alt="Fisofi_7" src="https://github.com/user-attachments/assets/44f3e2ad-d960-4135-bed3-e77c8bfcab69" />
</details>

*(Note: Screenshots are taken from the Chrome device emulator for rapid testing, but the UI is fully responsive for mobile devices).*

## 🚀 How to Run Locally

This project was built using the Flutter SDK. To run it on your local machine:

**1. Prerequisites**
Ensure you have Flutter installed. You can verify this by running:
```bash
flutter --version
```

## 2. Clone and Setup
Clone this repository and navigate into the project folder:

```Bash
git clone [https://github.com/YourUsername/fisofi_tech_challenge.git](https://github.com/YourUsername/fisofi_tech_challenge.git)
cd fisofi_tech_challenge
```

3. Install Dependencies

```Bash
flutter pub get
```
4. Run the Application
For the fastest evaluation experience, run the app via Chrome (or your preferred mobile emulator):

```Bash
flutter run -d chrome
```
## 🏗️ Architecture & Principles (MVC and separations of concern)

The app utilizes Flutter's native, highly efficient ChangeNotifier and ListenableBuilder pattern.
Separation of Concerns (MVC Pattern)
The codebase strictly separates the UI (Views) from the business logic (Controllers) and data blueprints (Models).

Controllers (ChangeNotifier): They exist to keep track of the logic only, hold the mutable state, perform the = validations (like checking win conditions or finding duplicate names), and call notifyListeners() to rebuild only the necessary parts of the UI.

Views (ListenableBuilder): They only handle painting pixels and passing user taps directly to the Controller.

Reusable Components: The UI relies heavily on composition. Buttons, sliders, and dialogs are extracted into isolated StatelessWidget classes in the widgets/ folder to ensure DRY (Don't Repeat Yourself) principles.

### Directory Structure

```Bash
lib/
├── constants/
│   └── game_config.dart             # Static word pairs and undercover math, jsut some static data
├── controllers/
│   ├── game_session_controller.dart # Manages voting math and win conditions
│   ├── game_setup_controller.dart   # Handles player creation and validation
│   └── reveal_controller.dart       # Handles the pass-and-play UI state
├── models/
│   ├── game_session.dart            # Wrapper for the active round and players
│   └── player.dart                  # Player blueprint (Name, Role, Secret Word)
├── screens/
│   ├── player_setup_screen.dart   
│   ├── role_reveal_screen.dart    
│   └── voting_screen.dart         
├── utils/                           # Helper functions and utilities (Nohting here)
├── widgets/
│   ├── game_result_dialog.dart      # Reusable popup for ties/eliminations/wins
│   ├── number_slider.dart         
│   ├── primary_button.dart          # Global custom button
│   ├── result_dialog.dart           # Extracted dialog component
│   ├── role_reveal_hidden.dart      # Extracted component
│   ├── role_reveal_revealed.dart    # Extracted component
│   └── voting_player_tile.dart      # Extracted list tile for the voting screen
└── main.dart                        # App entry point and global theme
```

## Video Sections

- My Development Workflow -> 0:00
- Player Setup Screen & Count Validation -> 7:03
- Closing issues Automatically ( workflow) -> 22:25
- Role & Word Assignment Logic -> 23:25
- Pass-and-Play Identity Reveal UI -> 29:56
- Voting Screen & Elimination Logic -> 36:54
- Win Conditions & Game Restart -> 44:23
- Final Considerations -> 57:10

  
