# Backups

I've decided to split my backups into two different purposes:

- **Computer backup**: Broad data such as photos, videos, old projects, spreadsheets, taxes, etc.
- **Passwords backup**: Passwords stored in my password manager.

## Table of Contents

1. [Computer backup](#computer-backup)
2. [Passwords backup](#passwords-backup)
   1. [Prerequisites](#prerequisites)
   2. [Usage](#usage)

## Computer backup

TODO

## Passwords backup

My strategy for securely storing passwords is to avoid knowing them at all. Instead, I use a password manager to store all my passwords.

However, there's one potential flaw: what if, for any reason, the password manager becomes unavailable? I'm not talking about losing access credentials, as I already have a strategy for that. Imagine the third-party provider simply disappears. In such a scenario, all my passwords would be lost. What now?

To address this risk, I've decided to back up my passwords periodically to ensure I don't lose access to all my accounts in the event of such a disaster.

This strategy requires caution: it's essential to ensure that only I can retrieve these passwords.

Here is the step-by-step process I follow to recover my passwords.

### Prerequisites

Ensure the following dependencies are installed and configured:

- **Ansible** (for Ansible Vault):
  - Required to decrypt the passwords backup configuration data securely.
  - Install it using [the official guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html).
- **BorgBackup** (`borg`):
  - Required to list and extract password backups.
  - Install it by following the [installation guide](https://borgbackup.readthedocs.io/en/stable/installation.html).
- **Ansible Vault password**: Ensure you know it.
- **Borg passphrase**: Ensure you know it.

### Usage

1. Download the [encrypted file](../secrets/passwords-backup.config) that can be decrypted using your vault password.
2. Decrypt the file to access metadata about the servers/devices storing your password backups. This file contains only non-sensitive data.
3. List the password backups on the most convenient server/device at the time. This step will prompt you for the repository passphrase:

   ```bash
   borg list /PATH/TO/REPO
   ```

4. Extract the backup. This step will also prompt you for the repository passphrase:

   ```bash
   borg extract /PATH/TO/REPO::ARCHIVE_NAME
   ```
