/*
  SPDX-License-Identifier: Apache-2.0
*/

import {Object, Property} from 'fabric-contract-api';

@Object()
export class Sertifikat {
    @Property()
    public ID: string;

    @Property()
    public NIS: string;

    @Property()
    public Nama: string;

    @Property()
    public JK: string;

    @Property()
    public ProgramKompetensi : string;

    @Property()
    public File: string;

    @Property()
    public Persetujuan: string;
}