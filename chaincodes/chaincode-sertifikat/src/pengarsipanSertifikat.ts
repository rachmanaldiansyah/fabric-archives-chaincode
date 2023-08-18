/*
 * SPDX-License-Identifier: Apache-2.0
 */
// Deterministic JSON.stringify()
import {
  Context,
  Contract,
  Info,
  Returns,
  Transaction,
} from "fabric-contract-api";
import stringify from "json-stringify-deterministic";
import sortKeysRecursive from "sort-keys-recursive";
import { Sertifikat } from "./sertifikat";

@Info({
  title: "AssetTransfer",
  description: "Smart contract for trading assets",
})
export class PengarsipanSertifikat extends Contract {
  // CreateAsset issues a new asset to the world state with given details.
  @Transaction()
  public async CreateAsset(
    ctx: Context,
    no_sertifikat: string,
    nis: string,
    nama: string,
    jk: string,
    keahlian: string,
    arsip_sertifikat: string,
    createdAt: string,
    konfirmasi_kepsek: string,
    konfirmasi_kepsekUpdatedAt: string,
    konfirmasi_mitra: string,
    konfirmasi_mitraUpdatedAt: string,
    konfirmasi_uploadToBlockchain: string
  ): Promise<String> {
    const exists = await this.AssetExists(ctx, no_sertifikat);
    if (exists) {
      throw new Error(`The asset ${no_sertifikat} already exists`);
    }

    const asset: Sertifikat = {
      NoSertifikat: no_sertifikat,
      NIS: nis,
      Nama: nama,
      JK: jk,
      Keahlian: keahlian,
      ArsipSertifikat: arsip_sertifikat,
      TanggalArsip: createdAt,
      KonfirmasiKepsek: konfirmasi_kepsek,
      TanggalKonfirmasiKepsek: konfirmasi_kepsekUpdatedAt,
      KonfirmasiMitra: konfirmasi_mitra,
      TanggalKonfirmasiMitra: konfirmasi_mitraUpdatedAt,
      TanggalUpload: konfirmasi_uploadToBlockchain
    };

    // we insert data in alphabetic order using 'json-stringify-deterministic' and 'sort-keys-recursive'
    await ctx.stub.putState(
      no_sertifikat,
      Buffer.from(stringify(sortKeysRecursive(asset)))
    );
    const idTx = ctx.stub.getTxID();
    return (
      "Pengarsipan sertifikat uji kompetensi telah berhasil dilakukan, ID Transaksi: " +
      idTx
    );
  }

  // ReadAsset returns the asset stored in the world state with given id.
  @Transaction(false)
  public async ReadAsset(ctx: Context, no_sertifikat: string): Promise<string> {
    const assetJSON = await ctx.stub.getState(no_sertifikat); // get the asset from chaincode state
    if (!assetJSON || assetJSON.length === 0) {
      throw new Error(`The asset ${no_sertifikat} does not exist`);
    }
    return assetJSON.toString();
  }

  // UpdateAsset updates an existing asset in the world state with provided parameters.
  @Transaction()
  public async UpdateAsset(
    ctx: Context,
    no_sertifikat: string,
    nis: string,
    nama: string,
    jk: string,
    keahlian: string,
    arsip_sertifikat: string,
    createdAt: string,
    konfirmasi_kepsek: string,
    konfirmasi_kepsekUpdatedAt: string,
    konfirmasi_mitra: string,
    konfirmasi_mitraUpdatedAt: string,
    konfirmasi_uploadToBlockchain: string
  ): Promise<String> {
    const exists = await this.AssetExists(ctx, no_sertifikat);
    if (!exists) {
      throw new Error(`The asset ${no_sertifikat} does not exist`);
    }

    // overwriting original asset with new asset
    const updatedAsset: Sertifikat = {
      NoSertifikat: no_sertifikat,
      NIS: nis,
      Nama: nama,
      JK: jk,
      Keahlian: keahlian,
      ArsipSertifikat: arsip_sertifikat,
      TanggalArsip: createdAt,
      KonfirmasiKepsek: konfirmasi_kepsek,
      TanggalKonfirmasiKepsek: konfirmasi_kepsekUpdatedAt,
      KonfirmasiMitra: konfirmasi_mitra,
      TanggalKonfirmasiMitra: konfirmasi_mitraUpdatedAt,
      TanggalUpload: konfirmasi_uploadToBlockchain,
    };

    // we insert data in alphabetic order using 'json-stringify-deterministic' and 'sort-keys-recursive'
    await ctx.stub.putState(
      no_sertifikat,
      Buffer.from(stringify(sortKeysRecursive(updatedAsset)))
    );
    const idTrx = ctx.stub.getTxID();
    return (
      "Ubah data arsip sertifikat telah berhasil diubah, ID Transaksi: " + idTrx
    );
  }

  // DeleteAsset deletes an given asset from the world state.
  @Transaction()
  public async DeleteAsset(ctx: Context, no_sertifikat: string): Promise<void> {
    const exists = await this.AssetExists(ctx, no_sertifikat);
    if (!exists) {
      throw new Error(`The asset ${no_sertifikat} does not exist`);
    }
    return ctx.stub.deleteState(no_sertifikat);
  }

  // AssetExists returns true when asset with given ID exists in world state.
  @Transaction(false)
  @Returns("boolean")
  public async AssetExists(
    ctx: Context,
    no_sertifikat: string
  ): Promise<boolean> {
    const assetJSON = await ctx.stub.getState(no_sertifikat);
    return assetJSON && assetJSON.length > 0;
  }

  // GetAllAssets returns all assets found in the world state.
  @Transaction(false)
  @Returns("string")
  public async GetAllAssets(ctx: Context): Promise<string> {
    const allResults = [];
    // range query with empty string for startKey and endKey does an open-ended query of all assets in the chaincode namespace.
    const iterator = await ctx.stub.getStateByRange("", "");
    let result = await iterator.next();
    while (!result.done) {
      const strValue = Buffer.from(result.value.value.toString()).toString(
        "utf8"
      );
      let record: string;
      try {
        record = JSON.parse(strValue);
      } catch (err) {
        console.log(err);
        record = strValue;
      }
      allResults.push(record);
      result = await iterator.next();
    }
    return JSON.stringify(allResults);
  }

  // VerifyArsipSertifikat verifies and returns the requested asset by no_sertifikat.
  @Transaction(false)
  @Returns("string")
  public async VerifyArsipSertifikat(
    ctx: Context,
    no_sertifikat: string
  ): Promise<string> {
    const assetJSON = await ctx.stub.getState(no_sertifikat);
    if (!assetJSON || assetJSON.length === 0) {
      throw new Error(`The asset ${no_sertifikat} does not exist`);
    }

    return assetJSON.toString();
  }
}
