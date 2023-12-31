/*
  SPDX-License-Identifier: Apache-2.0
*/

import {Object, Property} from 'fabric-contract-api';

@Object()
export class Ijazah {
    @Property()
    public NoIjazah: string;

    @Property()
    public NISN: string;

    @Property()
    public NIS: string;

    @Property()
    public Nama: string;

    @Property()
    public JK: string;

    @Property()
    public NamaOrangtua: string;

    @Property()
    public Prodi : string;

    @Property()
    public ArsipIjazah: string;

    @Property()
    public TanggalArsip: string;

    @Property()
    public KonfirmasiKepsek: string;

    @Property()
    public TanggalKonfirmasiKepsek: string;

    @Property()
    public KonfirmasiKesiswaan: string;

    @Property()
    public TanggalKonfirmasiKesiswaan: string;

    @Property()
    public TanggalUpload: string
}