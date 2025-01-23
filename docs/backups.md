# Backups

I've decided to split my backups into two different categories:

- **Computer backup**: Broad data such as photos, videos, old projects, spreadsheets, taxes, etc.
- **Passwords backup**: Passwords stored in my password manager.

## Table of Contents

1. [Computer backup](#computer-backup)
   1. [Create new backup](#create-new-backup)
      1. [Prerequisites](#prerequisites)
      2. [Usage](#usage)
   2. [Recover backup](#recover-backup)
      1. [Prerequisites](#prerequisites-1)
      2. [Usage](#usage-1)
2. [Passwords backup](#passwords-backup)
   1. [Create new backup](#create-new-backup-1)
      1. [Prerequisites](#prerequisites-2)
      2. [Usage](#usage-2)
   2. [Recover previous backup](#recover-previous-backup)
      1. [Prerequisites](#prerequisites-3)
      2. [Usage](#usage-3)

## Computer backup

For my computer backup, I have a specific folder structure:

```text
.
├── personal/
│   └── ...
└── Documents/
    └── ...
```

- **personal**: Contains large files that don't need to be synced across devices and are rarely accessed but important to keep.
- **Documents**: Synced between Apple devices via iCloud. Files you want to access on your iPhone or iPad should be stored here.

### Create new backup

#### Prerequisites

Dependencies are installed automatically when the project is cloned, and the installation script is executed. The script will prompt you for the Ansible vault password, which is stored in 1Password.

#### Usage

1. Clone the project:
   ```bash
   git clone git@github.com:leorodriguesf/setup-computer.git ~/personal/projects/setup-computer
   ```
2. Install all dependencies:
   ```bash
   cd ~/personal/projects/setup-computer
   ./install
   ```
3. Export photos from the Photos app to `~/personal/media/icloud`.
4. Run the backup script:
   ```bash
   backup
   ```

### Recover backup

#### Prerequisites

Ensure the following dependencies are installed and configured:

- **BorgBackup** (`borg`):
  - Required to list and extract backups.
  - Install it by following the [installation guide](https://borgbackup.readthedocs.io/en/stable/installation.html).
- **Borg passphrase**: Stored in 1Password.

#### Usage

1. Check the servers/devices storing your backup in 1Password.
2. List the backups on the most convenient server/device. This step will prompt you for the repository passphrase:
   ```bash
   borg list /PATH/TO/REPO
   ```
3. Extract the backup to the current folder. This step will also prompt you for the repository passphrase:
   ```bash
   borg extract /PATH/TO/REPO::ARCHIVE_NAME
   ```

## Passwords backup

My strategy for securely storing passwords is to avoid knowing them at all. Instead, I use a password manager to store them.

However, there's one potential flaw: what if the password manager becomes unavailable? I'm not talking about losing access credentials, as I have a strategy for that. Imagine the third-party provider suddenly disappears. In such a scenario, all my passwords would be lost. What now?

To address this risk, I back up my passwords periodically to ensure I can recover access to my accounts in case of such a disaster. This strategy requires caution to ensure only I can retrieve the passwords.

Here is the step-by-step process I follow to recover my passwords.

### Create new backup

#### Prerequisites

Dependencies are installed automatically when the project is cloned, and the installation script is executed. The script will prompt you for the Ansible vault password, which is stored in 1Password.

#### Usage

1. Clone the project:
   ```bash
   git clone git@github.com:leorodriguesf/setup-computer.git ~/personal/projects/setup-computer
   ```
2. Install all dependencies:
   ```bash
   cd ~/personal/projects/setup-computer
   ./install
   ```
3. Run the backup script:
   ```bash
   backup-passwords
   ```

### Recover previous backup

#### Prerequisites

Ensure the following dependencies are installed and configured:

- **Ansible** (for Ansible Vault):
  - Required to decrypt backup configuration data securely.
  - Install it using [the official guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html).
- **BorgBackup** (`borg`):
  - Required to list and extract backups.
  - Install it by following the [installation guide](https://borgbackup.readthedocs.io/en/stable/installation.html).
- **Ansible Vault password**: Stored in 1Password.
- **Borg passphrase**: Stored in 1Password.

#### Usage

1. Download the [encrypted files](../emergency-kit).
2. Decrypt the files to access metadata about the servers/devices storing your password backups. This step will prompt you for the Ansible Vault password:
   ```bash
   ansible-vault decrypt passwords-backup.config
   ansible-vault decrypt passwords-backup-local-1.jpg
   ansible-vault decrypt passwords-backup-local-2.jpg
   ansible-vault decrypt passwords-backup-local-3.jpg
   ```
3. List the password backups on the most convenient server/device. This step will prompt you for the repository passphrase:
   ```bash
   borg list /PATH/TO/REPO
   ```
4. Extract the backup to the current folder. This step will also prompt you for the repository passphrase:
   ```bash
   borg extract /PATH/TO/REPO::ARCHIVE_NAME
   ```
