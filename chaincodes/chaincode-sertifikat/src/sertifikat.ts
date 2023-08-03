/*
  SPDX-License-Identifier: Apache-2.0
*/

import {Object, Property} from 'fabric-contract-api';

@Object()
export class Sertifikat {
    @Property()
    public NoSertifikat: String;

    @Property()
    public NIS: string;

    @Property()
    public Nama: string;

    @Property()
    public JK: string;

    @Property()
    public Keahlian : string;

    @Property()
    public ArsipSertifikat: string;

    @Property()
    public KonfirmasiKepsek: string;

    @Property()
    public KonfirmasiMitra: string;
}