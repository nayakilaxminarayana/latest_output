#!/bin/bash

# Update package lists
sudo apt update

# Install Python3 and pip
sudo apt-get install -y python3
sudo apt-get install -y python3-pip

# Install required Python packages
pip3 install pandas eth-account mnemonic openpyxl

# Python script content
python3 <<EOF
import pandas as pd
from eth_account import Account
from mnemonic import Mnemonic

# Function to create a Metamask-style wallet with seed phrase
def create_metamask_wallet():
    account = Account.create()
    mnemonic = Mnemonic("english").to_mnemonic(account._private_key)
    private_key_hex = account._private_key.hex()
    address = account.address
    return mnemonic, private_key_hex, address

# Function to save seed phrase, private key, and address to an Excel sheet
def save_to_excel(wallet_data, file_name='wallet_info.xlsx'):
    df = pd.DataFrame(wallet_data, columns=['Seed Phrase', 'Private Key', 'Address'])
    df.to_excel(file_name, index=False)
    print(f"Data saved to {file_name}")

# Main program
if __name__ == "__main__":
    # Create 100 Metamask-style wallets
    wallet_data = {'Seed Phrase': [], 'Private Key': [], 'Address': []}
    for _ in range(100):
        seed_phrase, private_key, address = create_metamask_wallet()
        wallet_data['Seed Phrase'].append(seed_phrase)
        wallet_data['Private Key'].append(private_key)
        wallet_data['Address'].append(address)

    # Save seed phrases, private keys, and addresses to Excel sheet
    save_to_excel(wallet_data)
EOF
