#!/usr/bin/env bash

generateArtifacts() {
  printHeadline "Generating basic configs" "U1F913"

  printItalics "Generating crypto material for Maarif" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-maarif.yaml" "peerOrganizations/maarif.orderer.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for KepalaSekolah" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-kepalasekolah.yaml" "peerOrganizations/kepsek.maarif.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Kesiswaan" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-kesiswaan.yaml" "peerOrganizations/kesiswaan.maarif.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Stafftu" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-stafftu.yaml" "peerOrganizations/stafftu.maarif.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Mitra" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-mitra.yaml" "peerOrganizations/mitra.maarif.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Siswa" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-siswa.yaml" "peerOrganizations/siswa.maarif.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating genesis block for group maarif" "U1F3E0"
  genesisBlockCreate "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config" "MaarifGenesis"

  # Create directory for chaincode packages to avoid permission errors on linux
  mkdir -p "$FABLO_NETWORK_ROOT/fabric-config/chaincode-packages"
}

startNetwork() {
  printHeadline "Starting network" "U1F680"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose up -d)
  sleep 4
}

generateChannelsArtifacts() {
  printHeadline "Generating config for 'ijazah'" "U1F913"
  createChannelTx "ijazah" "$FABLO_NETWORK_ROOT/fabric-config" "Ijazah" "$FABLO_NETWORK_ROOT/fabric-config/config"
  printHeadline "Generating config for 'sertifikat'" "U1F913"
  createChannelTx "sertifikat" "$FABLO_NETWORK_ROOT/fabric-config" "Sertifikat" "$FABLO_NETWORK_ROOT/fabric-config/config"
}

installChannels() {
  printHeadline "Creating 'ijazah' on KepalaSekolah/peer0" "U1F63B"
  docker exec -i cli.kepsek.maarif.ac.id bash -c "source scripts/channel_fns.sh; createChannelAndJoin 'ijazah' 'KepalaSekolahMSP' 'peer0.kepsek.maarif.ac.id:7041' 'crypto/users/Admin@kepsek.maarif.ac.id/msp' 'orderer0.maarif.maarif.orderer.ac.id:7030';"

  printItalics "Joining 'ijazah' on  KepalaSekolah/peer1" "U1F638"
  docker exec -i cli.kepsek.maarif.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'ijazah' 'KepalaSekolahMSP' 'peer1.kepsek.maarif.ac.id:7042' 'crypto/users/Admin@kepsek.maarif.ac.id/msp' 'orderer0.maarif.maarif.orderer.ac.id:7030';"
  printItalics "Joining 'ijazah' on  Kesiswaan/peer0" "U1F638"
  docker exec -i cli.kesiswaan.maarif.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'ijazah' 'KesiswaanMSP' 'peer0.kesiswaan.maarif.ac.id:7061' 'crypto/users/Admin@kesiswaan.maarif.ac.id/msp' 'orderer0.maarif.maarif.orderer.ac.id:7030';"
  printItalics "Joining 'ijazah' on  Stafftu/peer0" "U1F638"
  docker exec -i cli.stafftu.maarif.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'ijazah' 'StafftuMSP' 'peer0.stafftu.maarif.ac.id:7081' 'crypto/users/Admin@stafftu.maarif.ac.id/msp' 'orderer0.maarif.maarif.orderer.ac.id:7030';"
  printItalics "Joining 'ijazah' on  Siswa/peer0" "U1F638"
  docker exec -i cli.siswa.maarif.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'ijazah' 'SiswaMSP' 'peer0.siswa.maarif.ac.id:7121' 'crypto/users/Admin@siswa.maarif.ac.id/msp' 'orderer0.maarif.maarif.orderer.ac.id:7030';"
  printHeadline "Creating 'sertifikat' on KepalaSekolah/peer0" "U1F63B"
  docker exec -i cli.kepsek.maarif.ac.id bash -c "source scripts/channel_fns.sh; createChannelAndJoin 'sertifikat' 'KepalaSekolahMSP' 'peer0.kepsek.maarif.ac.id:7041' 'crypto/users/Admin@kepsek.maarif.ac.id/msp' 'orderer0.maarif.maarif.orderer.ac.id:7030';"

  printItalics "Joining 'sertifikat' on  KepalaSekolah/peer1" "U1F638"
  docker exec -i cli.kepsek.maarif.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'sertifikat' 'KepalaSekolahMSP' 'peer1.kepsek.maarif.ac.id:7042' 'crypto/users/Admin@kepsek.maarif.ac.id/msp' 'orderer0.maarif.maarif.orderer.ac.id:7030';"
  printItalics "Joining 'sertifikat' on  Stafftu/peer0" "U1F638"
  docker exec -i cli.stafftu.maarif.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'sertifikat' 'StafftuMSP' 'peer0.stafftu.maarif.ac.id:7081' 'crypto/users/Admin@stafftu.maarif.ac.id/msp' 'orderer0.maarif.maarif.orderer.ac.id:7030';"
  printItalics "Joining 'sertifikat' on  Mitra/peer0" "U1F638"
  docker exec -i cli.mitra.maarif.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'sertifikat' 'MitraMSP' 'peer0.mitra.maarif.ac.id:7101' 'crypto/users/Admin@mitra.maarif.ac.id/msp' 'orderer0.maarif.maarif.orderer.ac.id:7030';"
  printItalics "Joining 'sertifikat' on  Siswa/peer0" "U1F638"
  docker exec -i cli.siswa.maarif.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'sertifikat' 'SiswaMSP' 'peer0.siswa.maarif.ac.id:7121' 'crypto/users/Admin@siswa.maarif.ac.id/msp' 'orderer0.maarif.maarif.orderer.ac.id:7030';"
}

installChaincodes() {
  if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-ijazah")" ]; then
    local version="0.0.1"
    printHeadline "Packaging chaincode 'chaincode-ijazah'" "U1F60E"
    chaincodeBuild "chaincode-ijazah" "node" "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-ijazah" "16"
    chaincodePackage "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-ijazah" "$version" "node" printHeadline "Installing 'chaincode-ijazah' for KepalaSekolah" "U1F60E"
    chaincodeInstall "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-ijazah" "$version" ""
    chaincodeInstall "cli.kepsek.maarif.ac.id" "peer1.kepsek.maarif.ac.id:7042" "chaincode-ijazah" "$version" ""
    chaincodeApprove "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'chaincode-ijazah' for Kesiswaan" "U1F60E"
    chaincodeInstall "cli.kesiswaan.maarif.ac.id" "peer0.kesiswaan.maarif.ac.id:7061" "chaincode-ijazah" "$version" ""
    chaincodeApprove "cli.kesiswaan.maarif.ac.id" "peer0.kesiswaan.maarif.ac.id:7061" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'chaincode-ijazah' for Stafftu" "U1F60E"
    chaincodeInstall "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "chaincode-ijazah" "$version" ""
    chaincodeApprove "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'chaincode-ijazah' for Siswa" "U1F60E"
    chaincodeInstall "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "chaincode-ijazah" "$version" ""
    chaincodeApprove "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printItalics "Committing chaincode 'chaincode-ijazah' on channel 'ijazah' as 'KepalaSekolah'" "U1F618"
    chaincodeCommit "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" "peer0.kepsek.maarif.ac.id:7041,peer0.kesiswaan.maarif.ac.id:7061,peer0.stafftu.maarif.ac.id:7081,peer0.siswa.maarif.ac.id:7121" "" ""
  else
    echo "Warning! Skipping chaincode 'chaincode-ijazah' installation. Chaincode directory is empty."
    echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/chaincode-ijazah'"
  fi
  if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-sertifikat")" ]; then
    local version="0.0.1"
    printHeadline "Packaging chaincode 'chaincode-sertifikat'" "U1F60E"
    chaincodeBuild "chaincode-sertifikat" "node" "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-sertifikat" "16"
    chaincodePackage "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-sertifikat" "$version" "node" printHeadline "Installing 'chaincode-sertifikat' for KepalaSekolah" "U1F60E"
    chaincodeInstall "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-sertifikat" "$version" ""
    chaincodeInstall "cli.kepsek.maarif.ac.id" "peer1.kepsek.maarif.ac.id:7042" "chaincode-sertifikat" "$version" ""
    chaincodeApprove "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'chaincode-sertifikat' for Stafftu" "U1F60E"
    chaincodeInstall "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "chaincode-sertifikat" "$version" ""
    chaincodeApprove "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'chaincode-sertifikat' for Mitra" "U1F60E"
    chaincodeInstall "cli.mitra.maarif.ac.id" "peer0.mitra.maarif.ac.id:7101" "chaincode-sertifikat" "$version" ""
    chaincodeApprove "cli.mitra.maarif.ac.id" "peer0.mitra.maarif.ac.id:7101" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'chaincode-sertifikat' for Siswa" "U1F60E"
    chaincodeInstall "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "chaincode-sertifikat" "$version" ""
    chaincodeApprove "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printItalics "Committing chaincode 'chaincode-sertifikat' on channel 'sertifikat' as 'KepalaSekolah'" "U1F618"
    chaincodeCommit "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" "peer0.kepsek.maarif.ac.id:7041,peer0.stafftu.maarif.ac.id:7081,peer0.mitra.maarif.ac.id:7101,peer0.siswa.maarif.ac.id:7121" "" ""
  else
    echo "Warning! Skipping chaincode 'chaincode-sertifikat' installation. Chaincode directory is empty."
    echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/chaincode-sertifikat'"
  fi

}

installChaincode() {
  local chaincodeName="$1"
  if [ -z "$chaincodeName" ]; then
    echo "Error: chaincode name is not provided"
    exit 1
  fi

  local version="$2"
  if [ -z "$version" ]; then
    echo "Error: chaincode version is not provided"
    exit 1
  fi

  if [ "$chaincodeName" = "chaincode-ijazah" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-ijazah")" ]; then
      printHeadline "Packaging chaincode 'chaincode-ijazah'" "U1F60E"
      chaincodeBuild "chaincode-ijazah" "node" "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-ijazah" "16"
      chaincodePackage "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-ijazah" "$version" "node" printHeadline "Installing 'chaincode-ijazah' for KepalaSekolah" "U1F60E"
      chaincodeInstall "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-ijazah" "$version" ""
      chaincodeInstall "cli.kepsek.maarif.ac.id" "peer1.kepsek.maarif.ac.id:7042" "chaincode-ijazah" "$version" ""
      chaincodeApprove "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-ijazah' for Kesiswaan" "U1F60E"
      chaincodeInstall "cli.kesiswaan.maarif.ac.id" "peer0.kesiswaan.maarif.ac.id:7061" "chaincode-ijazah" "$version" ""
      chaincodeApprove "cli.kesiswaan.maarif.ac.id" "peer0.kesiswaan.maarif.ac.id:7061" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-ijazah' for Stafftu" "U1F60E"
      chaincodeInstall "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "chaincode-ijazah" "$version" ""
      chaincodeApprove "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-ijazah' for Siswa" "U1F60E"
      chaincodeInstall "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "chaincode-ijazah" "$version" ""
      chaincodeApprove "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printItalics "Committing chaincode 'chaincode-ijazah' on channel 'ijazah' as 'KepalaSekolah'" "U1F618"
      chaincodeCommit "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" "peer0.kepsek.maarif.ac.id:7041,peer0.kesiswaan.maarif.ac.id:7061,peer0.stafftu.maarif.ac.id:7081,peer0.siswa.maarif.ac.id:7121" "" ""

    else
      echo "Warning! Skipping chaincode 'chaincode-ijazah' install. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/chaincode-ijazah'"
    fi
  fi
  if [ "$chaincodeName" = "chaincode-sertifikat" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-sertifikat")" ]; then
      printHeadline "Packaging chaincode 'chaincode-sertifikat'" "U1F60E"
      chaincodeBuild "chaincode-sertifikat" "node" "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-sertifikat" "16"
      chaincodePackage "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-sertifikat" "$version" "node" printHeadline "Installing 'chaincode-sertifikat' for KepalaSekolah" "U1F60E"
      chaincodeInstall "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-sertifikat" "$version" ""
      chaincodeInstall "cli.kepsek.maarif.ac.id" "peer1.kepsek.maarif.ac.id:7042" "chaincode-sertifikat" "$version" ""
      chaincodeApprove "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-sertifikat' for Stafftu" "U1F60E"
      chaincodeInstall "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "chaincode-sertifikat" "$version" ""
      chaincodeApprove "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-sertifikat' for Mitra" "U1F60E"
      chaincodeInstall "cli.mitra.maarif.ac.id" "peer0.mitra.maarif.ac.id:7101" "chaincode-sertifikat" "$version" ""
      chaincodeApprove "cli.mitra.maarif.ac.id" "peer0.mitra.maarif.ac.id:7101" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-sertifikat' for Siswa" "U1F60E"
      chaincodeInstall "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "chaincode-sertifikat" "$version" ""
      chaincodeApprove "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printItalics "Committing chaincode 'chaincode-sertifikat' on channel 'sertifikat' as 'KepalaSekolah'" "U1F618"
      chaincodeCommit "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" "peer0.kepsek.maarif.ac.id:7041,peer0.stafftu.maarif.ac.id:7081,peer0.mitra.maarif.ac.id:7101,peer0.siswa.maarif.ac.id:7121" "" ""

    else
      echo "Warning! Skipping chaincode 'chaincode-sertifikat' install. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/chaincode-sertifikat'"
    fi
  fi
}

runDevModeChaincode() {
  local chaincodeName=$1
  if [ -z "$chaincodeName" ]; then
    echo "Error: chaincode name is not provided"
    exit 1
  fi

  if [ "$chaincodeName" = "chaincode-ijazah" ]; then
    local version="0.0.1"
    printHeadline "Approving 'chaincode-ijazah' for KepalaSekolah (dev mode)" "U1F60E"
    chaincodeApprove "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "ijazah" "chaincode-ijazah" "0.0.1" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'chaincode-ijazah' for Kesiswaan (dev mode)" "U1F60E"
    chaincodeApprove "cli.kesiswaan.maarif.ac.id" "peer0.kesiswaan.maarif.ac.id:7061" "ijazah" "chaincode-ijazah" "0.0.1" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'chaincode-ijazah' for Stafftu (dev mode)" "U1F60E"
    chaincodeApprove "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "ijazah" "chaincode-ijazah" "0.0.1" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'chaincode-ijazah' for Siswa (dev mode)" "U1F60E"
    chaincodeApprove "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "ijazah" "chaincode-ijazah" "0.0.1" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printItalics "Committing chaincode 'chaincode-ijazah' on channel 'ijazah' as 'KepalaSekolah' (dev mode)" "U1F618"
    chaincodeCommit "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "ijazah" "chaincode-ijazah" "0.0.1" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" "peer0.kepsek.maarif.ac.id:7041,peer0.kesiswaan.maarif.ac.id:7061,peer0.stafftu.maarif.ac.id:7081,peer0.siswa.maarif.ac.id:7121" "" ""

  fi
  if [ "$chaincodeName" = "chaincode-sertifikat" ]; then
    local version="0.0.1"
    printHeadline "Approving 'chaincode-sertifikat' for KepalaSekolah (dev mode)" "U1F60E"
    chaincodeApprove "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "sertifikat" "chaincode-sertifikat" "0.0.1" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'chaincode-sertifikat' for Stafftu (dev mode)" "U1F60E"
    chaincodeApprove "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "sertifikat" "chaincode-sertifikat" "0.0.1" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'chaincode-sertifikat' for Mitra (dev mode)" "U1F60E"
    chaincodeApprove "cli.mitra.maarif.ac.id" "peer0.mitra.maarif.ac.id:7101" "sertifikat" "chaincode-sertifikat" "0.0.1" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'chaincode-sertifikat' for Siswa (dev mode)" "U1F60E"
    chaincodeApprove "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "sertifikat" "chaincode-sertifikat" "0.0.1" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
    printItalics "Committing chaincode 'chaincode-sertifikat' on channel 'sertifikat' as 'KepalaSekolah' (dev mode)" "U1F618"
    chaincodeCommit "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "sertifikat" "chaincode-sertifikat" "0.0.1" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" "peer0.kepsek.maarif.ac.id:7041,peer0.stafftu.maarif.ac.id:7081,peer0.mitra.maarif.ac.id:7101,peer0.siswa.maarif.ac.id:7121" "" ""

  fi
}

upgradeChaincode() {
  local chaincodeName="$1"
  if [ -z "$chaincodeName" ]; then
    echo "Error: chaincode name is not provided"
    exit 1
  fi

  local version="$2"
  if [ -z "$version" ]; then
    echo "Error: chaincode version is not provided"
    exit 1
  fi

  if [ "$chaincodeName" = "chaincode-ijazah" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-ijazah")" ]; then
      printHeadline "Packaging chaincode 'chaincode-ijazah'" "U1F60E"
      chaincodeBuild "chaincode-ijazah" "node" "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-ijazah" "16"
      chaincodePackage "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-ijazah" "$version" "node" printHeadline "Installing 'chaincode-ijazah' for KepalaSekolah" "U1F60E"
      chaincodeInstall "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-ijazah" "$version" ""
      chaincodeInstall "cli.kepsek.maarif.ac.id" "peer1.kepsek.maarif.ac.id:7042" "chaincode-ijazah" "$version" ""
      chaincodeApprove "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-ijazah' for Kesiswaan" "U1F60E"
      chaincodeInstall "cli.kesiswaan.maarif.ac.id" "peer0.kesiswaan.maarif.ac.id:7061" "chaincode-ijazah" "$version" ""
      chaincodeApprove "cli.kesiswaan.maarif.ac.id" "peer0.kesiswaan.maarif.ac.id:7061" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-ijazah' for Stafftu" "U1F60E"
      chaincodeInstall "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "chaincode-ijazah" "$version" ""
      chaincodeApprove "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-ijazah' for Siswa" "U1F60E"
      chaincodeInstall "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "chaincode-ijazah" "$version" ""
      chaincodeApprove "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printItalics "Committing chaincode 'chaincode-ijazah' on channel 'ijazah' as 'KepalaSekolah'" "U1F618"
      chaincodeCommit "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "ijazah" "chaincode-ijazah" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" "peer0.kepsek.maarif.ac.id:7041,peer0.kesiswaan.maarif.ac.id:7061,peer0.stafftu.maarif.ac.id:7081,peer0.siswa.maarif.ac.id:7121" "" ""

    else
      echo "Warning! Skipping chaincode 'chaincode-ijazah' upgrade. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/chaincode-ijazah'"
    fi
  fi
  if [ "$chaincodeName" = "chaincode-sertifikat" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-sertifikat")" ]; then
      printHeadline "Packaging chaincode 'chaincode-sertifikat'" "U1F60E"
      chaincodeBuild "chaincode-sertifikat" "node" "$CHAINCODES_BASE_DIR/./chaincodes/chaincode-sertifikat" "16"
      chaincodePackage "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-sertifikat" "$version" "node" printHeadline "Installing 'chaincode-sertifikat' for KepalaSekolah" "U1F60E"
      chaincodeInstall "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "chaincode-sertifikat" "$version" ""
      chaincodeInstall "cli.kepsek.maarif.ac.id" "peer1.kepsek.maarif.ac.id:7042" "chaincode-sertifikat" "$version" ""
      chaincodeApprove "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-sertifikat' for Stafftu" "U1F60E"
      chaincodeInstall "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "chaincode-sertifikat" "$version" ""
      chaincodeApprove "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-sertifikat' for Mitra" "U1F60E"
      chaincodeInstall "cli.mitra.maarif.ac.id" "peer0.mitra.maarif.ac.id:7101" "chaincode-sertifikat" "$version" ""
      chaincodeApprove "cli.mitra.maarif.ac.id" "peer0.mitra.maarif.ac.id:7101" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'chaincode-sertifikat' for Siswa" "U1F60E"
      chaincodeInstall "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "chaincode-sertifikat" "$version" ""
      chaincodeApprove "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" ""
      printItalics "Committing chaincode 'chaincode-sertifikat' on channel 'sertifikat' as 'KepalaSekolah'" "U1F618"
      chaincodeCommit "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041" "sertifikat" "chaincode-sertifikat" "$version" "orderer0.maarif.maarif.orderer.ac.id:7030" "" "false" "" "peer0.kepsek.maarif.ac.id:7041,peer0.stafftu.maarif.ac.id:7081,peer0.mitra.maarif.ac.id:7101,peer0.siswa.maarif.ac.id:7121" "" ""

    else
      echo "Warning! Skipping chaincode 'chaincode-sertifikat' upgrade. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/chaincode-sertifikat'"
    fi
  fi
}

notifyOrgsAboutChannels() {
  printHeadline "Creating new channel config blocks" "U1F537"
  createNewChannelUpdateTx "ijazah" "KepalaSekolahMSP" "Ijazah" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "ijazah" "KesiswaanMSP" "Ijazah" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "ijazah" "StafftuMSP" "Ijazah" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "ijazah" "SiswaMSP" "Ijazah" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "sertifikat" "KepalaSekolahMSP" "Sertifikat" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "sertifikat" "StafftuMSP" "Sertifikat" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "sertifikat" "MitraMSP" "Sertifikat" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "sertifikat" "SiswaMSP" "Sertifikat" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"

  printHeadline "Notyfing orgs about channels" "U1F4E2"
  notifyOrgAboutNewChannel "ijazah" "KepalaSekolahMSP" "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id" "orderer0.maarif.maarif.orderer.ac.id:7030"
  notifyOrgAboutNewChannel "ijazah" "KesiswaanMSP" "cli.kesiswaan.maarif.ac.id" "peer0.kesiswaan.maarif.ac.id" "orderer0.maarif.maarif.orderer.ac.id:7030"
  notifyOrgAboutNewChannel "ijazah" "StafftuMSP" "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id" "orderer0.maarif.maarif.orderer.ac.id:7030"
  notifyOrgAboutNewChannel "ijazah" "SiswaMSP" "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id" "orderer0.maarif.maarif.orderer.ac.id:7030"
  notifyOrgAboutNewChannel "sertifikat" "KepalaSekolahMSP" "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id" "orderer0.maarif.maarif.orderer.ac.id:7030"
  notifyOrgAboutNewChannel "sertifikat" "StafftuMSP" "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id" "orderer0.maarif.maarif.orderer.ac.id:7030"
  notifyOrgAboutNewChannel "sertifikat" "MitraMSP" "cli.mitra.maarif.ac.id" "peer0.mitra.maarif.ac.id" "orderer0.maarif.maarif.orderer.ac.id:7030"
  notifyOrgAboutNewChannel "sertifikat" "SiswaMSP" "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id" "orderer0.maarif.maarif.orderer.ac.id:7030"

  printHeadline "Deleting new channel config blocks" "U1F52A"
  deleteNewChannelUpdateTx "ijazah" "KepalaSekolahMSP" "cli.kepsek.maarif.ac.id"
  deleteNewChannelUpdateTx "ijazah" "KesiswaanMSP" "cli.kesiswaan.maarif.ac.id"
  deleteNewChannelUpdateTx "ijazah" "StafftuMSP" "cli.stafftu.maarif.ac.id"
  deleteNewChannelUpdateTx "ijazah" "SiswaMSP" "cli.siswa.maarif.ac.id"
  deleteNewChannelUpdateTx "sertifikat" "KepalaSekolahMSP" "cli.kepsek.maarif.ac.id"
  deleteNewChannelUpdateTx "sertifikat" "StafftuMSP" "cli.stafftu.maarif.ac.id"
  deleteNewChannelUpdateTx "sertifikat" "MitraMSP" "cli.mitra.maarif.ac.id"
  deleteNewChannelUpdateTx "sertifikat" "SiswaMSP" "cli.siswa.maarif.ac.id"
}

printStartSuccessInfo() {
  printHeadline "Done! Enjoy your fresh network" "U1F984"
}

stopNetwork() {
  printHeadline "Stopping network" "U1F68F"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose stop)
  sleep 4
}

networkDown() {
  printHeadline "Destroying network" "U1F916"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose down)

  printf "\nRemoving chaincode containers & images... \U1F5D1 \n"
  for container in $(docker ps -a | grep "dev-peer0.kepsek.maarif.ac.id-chaincode-ijazah" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.kepsek.maarif.ac.id-chaincode-ijazah*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer1.kepsek.maarif.ac.id-chaincode-ijazah" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer1.kepsek.maarif.ac.id-chaincode-ijazah*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.kesiswaan.maarif.ac.id-chaincode-ijazah" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.kesiswaan.maarif.ac.id-chaincode-ijazah*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.stafftu.maarif.ac.id-chaincode-ijazah" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.stafftu.maarif.ac.id-chaincode-ijazah*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.siswa.maarif.ac.id-chaincode-ijazah" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.siswa.maarif.ac.id-chaincode-ijazah*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.kepsek.maarif.ac.id-chaincode-sertifikat" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.kepsek.maarif.ac.id-chaincode-sertifikat*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer1.kepsek.maarif.ac.id-chaincode-sertifikat" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer1.kepsek.maarif.ac.id-chaincode-sertifikat*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.stafftu.maarif.ac.id-chaincode-sertifikat" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.stafftu.maarif.ac.id-chaincode-sertifikat*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.mitra.maarif.ac.id-chaincode-sertifikat" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.mitra.maarif.ac.id-chaincode-sertifikat*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.siswa.maarif.ac.id-chaincode-sertifikat" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.siswa.maarif.ac.id-chaincode-sertifikat*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done

  printf "\nRemoving generated configs... \U1F5D1 \n"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/crypto-config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/chaincode-packages"

  printHeadline "Done! Network was purged" "U1F5D1"
}
