import pandas as pd
from eth_account import Account
from mnemonic import Mnemonic

def create_metamask_wallet():
    # Enable Mnemonic features
    Account.enable_unaudited_hdwallet_features()

    # Generate a 12-word mnemonic
    mnemonic = Mnemonic("english")
    seed_phrase = mnemonic.generate(strength=128)  # 12 words

    # Create an Ethereum account using the mnemonic
    account = Account.from_mnemonic(seed_phrase)

    # Extract private key and address
    private_key_hex = account._private_key.hex()
    address = account.address

    return seed_phrase, private_key_hex, address

def save_to_excel(wallet_data, file_name='Final_output_1000_wallet_info.xlsx'):
    df = pd.DataFrame(wallet_data, columns=['Seed Phrase', 'Private Key', 'Address'])
    df.to_excel(file_name, index=False)
    print(f"Data saved to {file_name}")

# Create 10 Metamask-style wallets and save to Excel
wallet_data = {'Seed Phrase': [], 'Private Key': [], 'Address': []}
for _ in range(1000):
    seed_phrase, private_key, address = create_metamask_wallet()
    wallet_data['Seed Phrase'].append(seed_phrase)
    wallet_data['Private Key'].append(private_key)
    wallet_data['Address'].append(address)

save_to_excel(wallet_data)
