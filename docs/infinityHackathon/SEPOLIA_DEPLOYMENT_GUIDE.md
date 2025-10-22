# ⚡ Quick Deploy: Sepolia Smart Contract

**Tujuan:** Deploy minimal proof-of-concept contract ke Sepolia testnet untuk memenuhi requirement hackathon.

**Estimated Time:** 2-3 jam (termasuk setup)

---

## 🎯 Opsi Deployment

### Opsi A: Hardhat (Recommended - Easier)
### Opsi B: Foundry (Advanced - Faster)
### Opsi C: Remix IDE (Simplest - Browser-based)

**Rekomendasi:** Gunakan **Remix IDE** jika Anda baru pertama kali. Gunakan **Hardhat** jika familiar dengan Node.js.

---

## 🌐 Opsi C: Remix IDE (TERCEPAT - 30 MENIT!)

### Step 1: Get Sepolia Testnet ETH (10 menit)

**1.1. Buat Wallet MetaMask:**
- Install MetaMask extension: https://metamask.io/
- Create new wallet
- SAVE seed phrase dengan aman!

**1.2. Add Sepolia Network ke MetaMask:**
- Klik network dropdown (biasanya "Ethereum Mainnet")
- Show test networks: Settings → Advanced → Show test networks ON
- Select "Sepolia test network"

**1.3. Get Free Sepolia ETH:**
Visit faucets (perlu paling tidak satu):
- https://sepoliafaucet.com/
- https://www.alchemy.com/faucets/ethereum-sepolia
- https://faucet.quicknode.com/ethereum/sepolia

Cara pakai:
1. Copy alamat wallet Anda dari MetaMask
2. Paste di faucet website
3. Complete captcha/login requirement
4. Wait 1-5 menit untuk receive 0.5 SepoliaETH

---

### Step 2: Deploy via Remix IDE (15 menit)

**2.1. Open Remix IDE:**
- Go to: https://remix.ethereum.org/

**2.2. Create New File:**
- Left sidebar → File Explorer
- Click "Create New File" icon
- Name: `VaultNotesProof.sol`

**2.3. Paste Smart Contract Code:**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title VaultNotes Proof-of-Creation Registry
/// @notice Minimal implementation for Infinity Hackathon OJK-Ekraf 2025
/// @dev This is a proof-of-concept. Full app is on ICP (Internet Computer Protocol)
contract VaultNotesProof {
    
    // Event emitted when a note is registered
    event NoteRegistered(
        bytes32 indexed noteId,
        address indexed creator,
        bytes32 contentHash,
        uint256 timestamp
    );
    
    // Struct to store note metadata
    struct Note {
        bytes32 contentHash;      // Hash of the content (for verification)
        uint256 timestamp;        // Block timestamp (proof of creation time)
        address creator;          // Address of the creator
        bool exists;              // Flag to check if note exists
    }
    
    // Mapping from noteId to Note
    mapping(bytes32 => Note) public notes;
    
    // Total number of notes registered
    uint256 public totalNotes;
    
    /// @notice Register a new note with proof-of-creation
    /// @param noteId Unique identifier for the note
    /// @param contentHash SHA-256 hash of the note content
    function registerNote(bytes32 noteId, bytes32 contentHash) external {
        require(!notes[noteId].exists, "Note already registered");
        require(contentHash != bytes32(0), "Invalid content hash");
        
        notes[noteId] = Note({
            contentHash: contentHash,
            timestamp: block.timestamp,
            creator: msg.sender,
            exists: true
        });
        
        totalNotes++;
        
        emit NoteRegistered(noteId, msg.sender, contentHash, block.timestamp);
    }
    
    /// @notice Verify a note's authenticity
    /// @param noteId The ID of the note to verify
    /// @return creator Address who registered the note
    /// @return contentHash Hash of the content
    /// @return timestamp When it was registered
    function verifyNote(bytes32 noteId) 
        external 
        view 
        returns (
            address creator,
            bytes32 contentHash,
            uint256 timestamp
        ) 
    {
        require(notes[noteId].exists, "Note does not exist");
        
        Note memory note = notes[noteId];
        return (note.creator, note.contentHash, note.timestamp);
    }
    
    /// @notice Check if a note exists
    /// @param noteId The ID to check
    /// @return exists True if note is registered
    function noteExists(bytes32 noteId) external view returns (bool) {
        return notes[noteId].exists;
    }
    
    /// @notice Get note details (public getter alternative)
    /// @param noteId The ID of the note
    /// @return Note struct with all details
    function getNote(bytes32 noteId) external view returns (Note memory) {
        require(notes[noteId].exists, "Note does not exist");
        return notes[noteId];
    }
}
```

**2.4. Compile Contract:**
- Left sidebar → Click "Solidity Compiler" icon (looks like "S")
- Compiler version: Select `0.8.20` or higher
- Click "Compile VaultNotesProof.sol" button
- Wait for green checkmark ✅

**2.5. Deploy to Sepolia:**
- Left sidebar → Click "Deploy & Run Transactions" icon (Ethereum logo)
- Environment: Change from "Remix VM" to **"Injected Provider - MetaMask"**
- MetaMask will popup → **Ensure you're on Sepolia network**, then connect
- Contract: Select "VaultNotesProof"
- Click **"Deploy"** button (orange)
- MetaMask popup → Confirm transaction (will cost ~0.001 SepoliaETH)
- Wait 10-30 seconds for confirmation

**2.6. Copy Contract Address:**
- After deployment, see "Deployed Contracts" section at bottom
- Click copy icon next to contract address
- Format: `0x1234...abcd`
- **SAVE THIS ADDRESS!** Ini yang akan Anda submit ke hackathon.

---

### Step 3: Verify Contract on Etherscan (5 menit)

**3.1. Go to Sepolia Etherscan:**
- Visit: https://sepolia.etherscan.io/
- Paste your contract address in search bar
- Click on your contract

**3.2. Verify Source Code:**
- Tab: "Contract" → Click "Verify and Publish"
- Compiler Type: Select "Solidity (Single file)"
- Compiler Version: `v0.8.20+commit...` (match what you used in Remix)
- License: MIT
- Click "Continue"

**3.3. Paste Source Code:**
- Copy ENTIRE code from Remix (including SPDX and comments)
- Paste in "Enter the Solidity Contract Code" box
- Optimization: No (unless you enabled in Remix)
- Click "Verify and Publish"

**3.4. Success!**
- You should see green checkmark ✅
- Now anyone can view your verified source code
- Copy Etherscan URL (e.g., `https://sepolia.etherscan.io/address/0x123...`)

---

### Step 4: Test Contract (Optional - 5 menit)

**Test in Remix:**

1. **Register a Note:**
   - In "Deployed Contracts" section
   - Expand contract functions
   - Find `registerNote` function
   - Input:
     - `noteId`: `0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef` (random 32 bytes)
     - `contentHash`: `0xabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcd` (random 32 bytes)
   - Click "transact" → Confirm in MetaMask
   - Wait for confirmation

2. **Verify the Note:**
   - Find `verifyNote` function
   - Input same `noteId` as above
   - Click "call" (blue button - free, no gas)
   - Should return:
     - creator: Your wallet address
     - contentHash: The hash you provided
     - timestamp: Unix timestamp

3. **Check Total Notes:**
   - Find `totalNotes` function
   - Click "call"
   - Should return `1` (or more if you registered multiple)

✅ If all works → Your contract is ready!

---

## 📝 Untuk Submission Form

### Copy These Details:

**Alamat Smart Contract (Sepolia):**
```
0x[YOUR_CONTRACT_ADDRESS_HERE]
```

**Etherscan Verification Link:**
```
https://sepolia.etherscan.io/address/0x[YOUR_CONTRACT_ADDRESS_HERE]
```

**Penjelasan di Submission Form:**

```
CATATAN SMART CONTRACT:

Alamat Sepolia: 0x[YOUR_ADDRESS]
Verification: https://sepolia.etherscan.io/address/0x[YOUR_ADDRESS]

Contract ini adalah PROOF-OF-CONCEPT minimal untuk memenuhi requirement hackathon.

APLIKASI UTAMA (VaultNotes) dibangun di Internet Computer Protocol (ICP), bukan Ethereum,
karena alasan berikut:

1. FULL-STACK ON-CHAIN: ICP bisa host frontend + backend + storage semuanya on-chain.
   Ethereum hanya untuk smart contracts, frontend masih harus di AWS/Vercel.

2. STORAGE COST: ICP = $0.46/GB/tahun. Ethereum = $1000s untuk storage yang sama.
   Untuk IP protection, kami butuh store encrypted content, bukan hanya hash.

3. USER EXPERIENCE: ICP pakai reverse gas model (users tidak bayar transaction fees).
   Ethereum users harus punya ETH dan bayar gas untuk setiap action.

4. PERFORMANCE: ICP finality 1-2 detik. Ethereum 15+ detik. Better UX untuk aplikasi.

ICP Canister ID (Main App): [isi dengan dfx canister id encrypted-notes-backend]
ICP Dashboard: https://dashboard.internetcomputer.org/canister/[canister-id]

Contract Sepolia ini hanya untuk demonstrasi blockchain timestamping concept.
Full implementation dengan encryption, AI, dan storage ada di ICP.
```

---

## 🛠️ Alternative: Hardhat (Jika Ingin Lebih Advanced)

### Setup Hardhat (30 menit)

```bash
# 1. Create project directory
mkdir vaultnotes-sepolia
cd vaultnotes-sepolia

# 2. Initialize npm project
npm init -y

# 3. Install Hardhat & dependencies
npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox

# 4. Initialize Hardhat project
npx hardhat init
# Select: Create a JavaScript project
# Accept defaults

# 5. Install additional dependencies
npm install dotenv
```

### Configuration

**1. Create `.env` file:**
```env
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_ALCHEMY_API_KEY
PRIVATE_KEY=your_metamask_private_key_here
ETHERSCAN_API_KEY=your_etherscan_api_key_here
```

**Get API Keys:**
- Alchemy: https://www.alchemy.com/ (free account)
- Etherscan: https://etherscan.io/apis (free account)
- Private Key: MetaMask → Account Details → Export Private Key (⚠️ JANGAN SHARE!)

**2. Update `hardhat.config.js`:**
```javascript
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL,
      accounts: [process.env.PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY
  }
};
```

**3. Create contract file:**
```bash
# Delete sample contract
rm contracts/Lock.sol

# Create new contract
touch contracts/VaultNotesProof.sol
```

Paste the Solidity code from above into `contracts/VaultNotesProof.sol`.

**4. Create deployment script:**
```bash
# Delete sample script
rm scripts/deploy.js

# Create new script
touch scripts/deploy.js
```

**Edit `scripts/deploy.js`:**
```javascript
const hre = require("hardhat");

async function main() {
  console.log("Deploying VaultNotesProof to Sepolia...");

  const VaultNotesProof = await hre.ethers.getContractFactory("VaultNotesProof");
  const contract = await VaultNotesProof.deploy();

  await contract.waitForDeployment();

  const address = await contract.getAddress();
  console.log("✅ VaultNotesProof deployed to:", address);
  console.log("📝 Save this address for hackathon submission!");
  console.log("🔍 View on Etherscan:", `https://sepolia.etherscan.io/address/${address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
```

### Deploy

```bash
# Compile contract
npx hardhat compile

# Deploy to Sepolia
npx hardhat run scripts/deploy.js --network sepolia

# Output will show contract address - SAVE IT!
```

### Verify on Etherscan

```bash
npx hardhat verify --network sepolia YOUR_CONTRACT_ADDRESS
```

---

## 📊 Contract Interaction Examples

### Using Remix (After Deployment)

**1. Register a Note for Demo:**
- noteId: Hash of "Demo Novel Chapter 1"
  - Use: `0x1111111111111111111111111111111111111111111111111111111111111111`
- contentHash: SHA-256 of actual content
  - Use: `0x2222222222222222222222222222222222222222222222222222222222222222`

**2. Verify the Note:**
- Call `verifyNote` with same noteId
- Show screenshot in pitch deck!

---

## 🎯 What to Include in Pitch Deck

**Slide about Smart Contract:**

```
TECHNICAL IMPLEMENTATION

Sepolia Testnet Smart Contract
• Address: 0x[YOUR_ADDRESS]
• Purpose: Proof-of-Creation timestamping
• Verified: ✅ on Etherscan

Key Functions:
- registerNote(): Immutable timestamp + creator proof
- verifyNote(): Public verification of authorship
- Emits events for transparency

Why also ICP?
Sepolia contract demonstrates CONCEPT.
ICP implementation provides:
✅ Full-stack hosting (frontend + backend)
✅ Affordable storage ($0.46/GB vs $1000s)
✅ Better UX (no gas fees for users)
✅ Encryption (vetKD)

[Include screenshot of verified contract on Etherscan]
```

---

## ⚠️ Important Security Notes

1. **NEVER commit `.env` to Git:**
   ```bash
   echo ".env" >> .gitignore
   ```

2. **Use separate wallet for testnet** (jangan pakai wallet dengan real ETH)

3. **Private key di `.env` adalah untuk DEVELOPMENT only**

4. **Untuk production, use hardware wallet or secure key management**

---

## 🐛 Troubleshooting

### Issue: "Insufficient funds for gas"
**Solution:** Get more Sepolia ETH from faucets di atas.

### Issue: "Nonce too high"
**Solution:** MetaMask → Settings → Advanced → Reset Account

### Issue: "Contract verification failed"
**Solution:** 
- Ensure compiler version exact match
- Check optimization settings match
- Try manual verification instead of CLI

### Issue: "Network timeout"
**Solution:**
- Check internet connection
- Try different RPC URL (Alchemy, Infura, QuickNode)
- Wait and retry in 5-10 minutes

---

## ✅ Final Checklist

Before submission, ensure you have:

- [ ] Contract deployed to Sepolia
- [ ] Contract address copied: `0x...`
- [ ] Contract verified on Etherscan
- [ ] Etherscan URL copied
- [ ] Tested at least one transaction (registerNote)
- [ ] Screenshot of verified contract (for pitch deck)
- [ ] Written explanation for submission form (why ICP + Sepolia)

---

## 🚀 Next Steps

After deploying Sepolia contract:
1. ✅ Update submission form with contract address
2. ✅ Add Etherscan verification link
3. ✅ Screenshot verified contract for pitch deck
4. ✅ Write explanation (template provided above)
5. ✅ Continue with other submission requirements

---

**Estimated Total Time:**
- Remix IDE: **30 minutes** ⚡ (RECOMMENDED)
- Hardhat: **1-2 hours** 🛠️ (if you want local development)

**Good luck! 🎉**
