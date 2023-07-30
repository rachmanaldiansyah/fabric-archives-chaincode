#!/usr/bin/env bash

source "$FABLO_NETWORK_ROOT/fabric-docker/scripts/channel-query-functions.sh"

set -eu

channelQuery() {
  echo "-> Channel query: " + "$@"

  if [ "$#" -eq 1 ]; then
    printChannelsHelp

  elif [ "$1" = "list" ] && [ "$2" = "kepalasekolah" ] && [ "$3" = "peer0" ]; then

    peerChannelList "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041"

  elif
    [ "$1" = "list" ] && [ "$2" = "kepalasekolah" ] && [ "$3" = "peer1" ]
  then

    peerChannelList "cli.kepsek.maarif.ac.id" "peer1.kepsek.maarif.ac.id:7042"

  elif
    [ "$1" = "list" ] && [ "$2" = "kesiswaan" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.kesiswaan.maarif.ac.id" "peer0.kesiswaan.maarif.ac.id:7061"

  elif
    [ "$1" = "list" ] && [ "$2" = "stafftu" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081"

  elif
    [ "$1" = "list" ] && [ "$2" = "mitra" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.mitra.maarif.ac.id" "peer0.mitra.maarif.ac.id:7101"

  elif
    [ "$1" = "list" ] && [ "$2" = "siswa" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121"

  elif

    [ "$1" = "getinfo" ] && [ "$2" = "arsip-ijazah" ] && [ "$3" = "kepalasekolah" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "arsip-ijazah" "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "arsip-ijazah" ] && [ "$4" = "kepalasekolah" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "arsip-ijazah" "cli.kepsek.maarif.ac.id" "$TARGET_FILE" "peer0.kepsek.maarif.ac.id:7041"

  elif [ "$1" = "fetch" ] && [ "$3" = "arsip-ijazah" ] && [ "$4" = "kepalasekolah" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "arsip-ijazah" "cli.kepsek.maarif.ac.id" "${BLOCK_NAME}" "peer0.kepsek.maarif.ac.id:7041" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "arsip-ijazah" ] && [ "$3" = "kepalasekolah" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfo "arsip-ijazah" "cli.kepsek.maarif.ac.id" "peer1.kepsek.maarif.ac.id:7042"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "arsip-ijazah" ] && [ "$4" = "kepalasekolah" ] && [ "$5" = "peer1" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "arsip-ijazah" "cli.kepsek.maarif.ac.id" "$TARGET_FILE" "peer1.kepsek.maarif.ac.id:7042"

  elif [ "$1" = "fetch" ] && [ "$3" = "arsip-ijazah" ] && [ "$4" = "kepalasekolah" ] && [ "$5" = "peer1" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "arsip-ijazah" "cli.kepsek.maarif.ac.id" "${BLOCK_NAME}" "peer1.kepsek.maarif.ac.id:7042" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "arsip-ijazah" ] && [ "$3" = "kesiswaan" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "arsip-ijazah" "cli.kesiswaan.maarif.ac.id" "peer0.kesiswaan.maarif.ac.id:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "arsip-ijazah" ] && [ "$4" = "kesiswaan" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "arsip-ijazah" "cli.kesiswaan.maarif.ac.id" "$TARGET_FILE" "peer0.kesiswaan.maarif.ac.id:7061"

  elif [ "$1" = "fetch" ] && [ "$3" = "arsip-ijazah" ] && [ "$4" = "kesiswaan" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "arsip-ijazah" "cli.kesiswaan.maarif.ac.id" "${BLOCK_NAME}" "peer0.kesiswaan.maarif.ac.id:7061" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "arsip-ijazah" ] && [ "$3" = "stafftu" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "arsip-ijazah" "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "arsip-ijazah" ] && [ "$4" = "stafftu" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "arsip-ijazah" "cli.stafftu.maarif.ac.id" "$TARGET_FILE" "peer0.stafftu.maarif.ac.id:7081"

  elif [ "$1" = "fetch" ] && [ "$3" = "arsip-ijazah" ] && [ "$4" = "stafftu" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "arsip-ijazah" "cli.stafftu.maarif.ac.id" "${BLOCK_NAME}" "peer0.stafftu.maarif.ac.id:7081" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "arsip-ijazah" ] && [ "$3" = "siswa" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "arsip-ijazah" "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "arsip-ijazah" ] && [ "$4" = "siswa" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "arsip-ijazah" "cli.siswa.maarif.ac.id" "$TARGET_FILE" "peer0.siswa.maarif.ac.id:7121"

  elif [ "$1" = "fetch" ] && [ "$3" = "arsip-ijazah" ] && [ "$4" = "siswa" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "arsip-ijazah" "cli.siswa.maarif.ac.id" "${BLOCK_NAME}" "peer0.siswa.maarif.ac.id:7121" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "arsip-sertifikat" ] && [ "$3" = "kepalasekolah" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "arsip-sertifikat" "cli.kepsek.maarif.ac.id" "peer0.kepsek.maarif.ac.id:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "arsip-sertifikat" ] && [ "$4" = "kepalasekolah" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "arsip-sertifikat" "cli.kepsek.maarif.ac.id" "$TARGET_FILE" "peer0.kepsek.maarif.ac.id:7041"

  elif [ "$1" = "fetch" ] && [ "$3" = "arsip-sertifikat" ] && [ "$4" = "kepalasekolah" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "arsip-sertifikat" "cli.kepsek.maarif.ac.id" "${BLOCK_NAME}" "peer0.kepsek.maarif.ac.id:7041" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "arsip-sertifikat" ] && [ "$3" = "kepalasekolah" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfo "arsip-sertifikat" "cli.kepsek.maarif.ac.id" "peer1.kepsek.maarif.ac.id:7042"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "arsip-sertifikat" ] && [ "$4" = "kepalasekolah" ] && [ "$5" = "peer1" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "arsip-sertifikat" "cli.kepsek.maarif.ac.id" "$TARGET_FILE" "peer1.kepsek.maarif.ac.id:7042"

  elif [ "$1" = "fetch" ] && [ "$3" = "arsip-sertifikat" ] && [ "$4" = "kepalasekolah" ] && [ "$5" = "peer1" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "arsip-sertifikat" "cli.kepsek.maarif.ac.id" "${BLOCK_NAME}" "peer1.kepsek.maarif.ac.id:7042" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "arsip-sertifikat" ] && [ "$3" = "stafftu" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "arsip-sertifikat" "cli.stafftu.maarif.ac.id" "peer0.stafftu.maarif.ac.id:7081"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "arsip-sertifikat" ] && [ "$4" = "stafftu" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "arsip-sertifikat" "cli.stafftu.maarif.ac.id" "$TARGET_FILE" "peer0.stafftu.maarif.ac.id:7081"

  elif [ "$1" = "fetch" ] && [ "$3" = "arsip-sertifikat" ] && [ "$4" = "stafftu" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "arsip-sertifikat" "cli.stafftu.maarif.ac.id" "${BLOCK_NAME}" "peer0.stafftu.maarif.ac.id:7081" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "arsip-sertifikat" ] && [ "$3" = "mitra" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "arsip-sertifikat" "cli.mitra.maarif.ac.id" "peer0.mitra.maarif.ac.id:7101"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "arsip-sertifikat" ] && [ "$4" = "mitra" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "arsip-sertifikat" "cli.mitra.maarif.ac.id" "$TARGET_FILE" "peer0.mitra.maarif.ac.id:7101"

  elif [ "$1" = "fetch" ] && [ "$3" = "arsip-sertifikat" ] && [ "$4" = "mitra" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "arsip-sertifikat" "cli.mitra.maarif.ac.id" "${BLOCK_NAME}" "peer0.mitra.maarif.ac.id:7101" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "arsip-sertifikat" ] && [ "$3" = "siswa" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "arsip-sertifikat" "cli.siswa.maarif.ac.id" "peer0.siswa.maarif.ac.id:7121"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "arsip-sertifikat" ] && [ "$4" = "siswa" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "arsip-sertifikat" "cli.siswa.maarif.ac.id" "$TARGET_FILE" "peer0.siswa.maarif.ac.id:7121"

  elif [ "$1" = "fetch" ] && [ "$3" = "arsip-sertifikat" ] && [ "$4" = "siswa" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "arsip-sertifikat" "cli.siswa.maarif.ac.id" "${BLOCK_NAME}" "peer0.siswa.maarif.ac.id:7121" "$TARGET_FILE"

  else

    echo "$@"
    echo "$1, $2, $3, $4, $5, $6, $7, $#"
    printChannelsHelp
  fi

}

printChannelsHelp() {
  echo "Channel management commands:"
  echo ""

  echo "fablo channel list kepalasekolah peer0"
  echo -e "\t List channels on 'peer0' of 'KepalaSekolah'".
  echo ""

  echo "fablo channel list kepalasekolah peer1"
  echo -e "\t List channels on 'peer1' of 'KepalaSekolah'".
  echo ""

  echo "fablo channel list kesiswaan peer0"
  echo -e "\t List channels on 'peer0' of 'Kesiswaan'".
  echo ""

  echo "fablo channel list stafftu peer0"
  echo -e "\t List channels on 'peer0' of 'Stafftu'".
  echo ""

  echo "fablo channel list mitra peer0"
  echo -e "\t List channels on 'peer0' of 'Mitra'".
  echo ""

  echo "fablo channel list siswa peer0"
  echo -e "\t List channels on 'peer0' of 'Siswa'".
  echo ""

  echo "fablo channel getinfo arsip-ijazah kepalasekolah peer0"
  echo -e "\t Get channel info on 'peer0' of 'KepalaSekolah'".
  echo ""
  echo "fablo channel fetch config arsip-ijazah kepalasekolah peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'KepalaSekolah'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> arsip-ijazah kepalasekolah peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'KepalaSekolah'".
  echo ""

  echo "fablo channel getinfo arsip-ijazah kepalasekolah peer1"
  echo -e "\t Get channel info on 'peer1' of 'KepalaSekolah'".
  echo ""
  echo "fablo channel fetch config arsip-ijazah kepalasekolah peer1 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer1' of 'KepalaSekolah'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> arsip-ijazah kepalasekolah peer1 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer1' of 'KepalaSekolah'".
  echo ""

  echo "fablo channel getinfo arsip-ijazah kesiswaan peer0"
  echo -e "\t Get channel info on 'peer0' of 'Kesiswaan'".
  echo ""
  echo "fablo channel fetch config arsip-ijazah kesiswaan peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Kesiswaan'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> arsip-ijazah kesiswaan peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Kesiswaan'".
  echo ""

  echo "fablo channel getinfo arsip-ijazah stafftu peer0"
  echo -e "\t Get channel info on 'peer0' of 'Stafftu'".
  echo ""
  echo "fablo channel fetch config arsip-ijazah stafftu peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Stafftu'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> arsip-ijazah stafftu peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Stafftu'".
  echo ""

  echo "fablo channel getinfo arsip-ijazah siswa peer0"
  echo -e "\t Get channel info on 'peer0' of 'Siswa'".
  echo ""
  echo "fablo channel fetch config arsip-ijazah siswa peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Siswa'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> arsip-ijazah siswa peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Siswa'".
  echo ""

  echo "fablo channel getinfo arsip-sertifikat kepalasekolah peer0"
  echo -e "\t Get channel info on 'peer0' of 'KepalaSekolah'".
  echo ""
  echo "fablo channel fetch config arsip-sertifikat kepalasekolah peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'KepalaSekolah'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> arsip-sertifikat kepalasekolah peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'KepalaSekolah'".
  echo ""

  echo "fablo channel getinfo arsip-sertifikat kepalasekolah peer1"
  echo -e "\t Get channel info on 'peer1' of 'KepalaSekolah'".
  echo ""
  echo "fablo channel fetch config arsip-sertifikat kepalasekolah peer1 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer1' of 'KepalaSekolah'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> arsip-sertifikat kepalasekolah peer1 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer1' of 'KepalaSekolah'".
  echo ""

  echo "fablo channel getinfo arsip-sertifikat stafftu peer0"
  echo -e "\t Get channel info on 'peer0' of 'Stafftu'".
  echo ""
  echo "fablo channel fetch config arsip-sertifikat stafftu peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Stafftu'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> arsip-sertifikat stafftu peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Stafftu'".
  echo ""

  echo "fablo channel getinfo arsip-sertifikat mitra peer0"
  echo -e "\t Get channel info on 'peer0' of 'Mitra'".
  echo ""
  echo "fablo channel fetch config arsip-sertifikat mitra peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Mitra'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> arsip-sertifikat mitra peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Mitra'".
  echo ""

  echo "fablo channel getinfo arsip-sertifikat siswa peer0"
  echo -e "\t Get channel info on 'peer0' of 'Siswa'".
  echo ""
  echo "fablo channel fetch config arsip-sertifikat siswa peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Siswa'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> arsip-sertifikat siswa peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Siswa'".
  echo ""

}
