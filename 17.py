import pandas as pd
from eth_account import Account
from mnemonic import Mnemonic

# Function to create a Metamask-style wallet with a 12-word seed phrase
def create_metamask_wallet():
    mnemonic = Mnemonic("english")
    account = Account.create()
    private_key_hex = account._private_key.hex()
    seed_phrase = mnemonic.to_mnemonic(account._private_key)
    address = account.address
    return seed_phrase, private_key_hex, address

# Function to save seed phrase, private key, and address to an Excel sheet
def save_to_excel(wallet_data, file_name='testlllwallet_info.xlsx'):
    df = pd.DataFrame(wallet_data, columns=['Seed Phrase', 'Private Key', 'Address'])
    df.to_excel(file_name, index=False)
    print(f"Data saved to {file_name}")

# Main program
if __name__ == "__main__":
    # Create 10 Metamask-style wallets with 12-word seed phrases
    wallet_data = {'Seed Phrase': [], 'Private Key': [], 'Address': []}
    for _ in range(10):
        seed_phrase, private_key, address = create_metamask_wallet()
        wallet_data['Seed Phrase'].append(seed_phrase)
        wallet_data['Private Key'].append(private_key)
        wallet_data['Address'].append(address)

    # Save seed phrases, private keys, and addresses to Excel sheet
    save_to_excel(wallet_data)
