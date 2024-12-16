program hitungTagihanListrik;

uses crt;

type
    user = record
        username: string; // menyimpan nama pengguna
        password: string; // menyimpan kata sandi
    end;

var
    akun: array[1..100] of user; // array untuk menyimpan hingga 100 akun
    jumlahAkun: integer = 0;     // menghitung jumlah akun terdaftar

// prosedur untuk mendaftarkan akun baru
procedure daftarAkun(var akunList: array of user; var jumlah: integer);
var
    usnBaru, passBaru: string;
begin
    writeln('=-= SIGNUP =-=');
    write('MASUKKAN USERNAME BARU: '); 
    readln(usnBaru);
    write('MASUKKAN PASSWORD BARU: ');
    readln(passBaru);

    inc(jumlah); // menambah jumlah akun
    akunList[jumlah].username := usnBaru; 
    akunList[jumlah].password := passBaru;
    writeln('AKUN BERHASIL DIDAFARKAN! SILAKAN LOGIN.');
end;

// fungsi untuk login ke akun
function login(var akunList: array of user; jumlah: integer): boolean;
var
    username, password: string;
    i: integer;
    masuk: boolean;
begin
    masuk := false; // inisialisasi status login
    writeln('=-= LOGIN =-=');
    repeat
        write('MASUKKAN USERNAME: ');
        readln(username);
        write('MASUKKAN PASSWORD: ');
        readln(password);

        // memeriksa username dan password
        for i := 1 to jumlah do
        begin
            if (akunList[i].username = username) and (akunList[i].password = password) then
            begin
                masuk := true; // login berhasil
                break;
            end;
        end;

        if not masuk then
            writeln('USERNAME ATAU PASSWORD SALAH. SILAKAN COBA LAGI.');
    until masuk;

    login := masuk; // mengembalikan status login
end;

// prosedur untuk menghitung tagihan listrik
procedure hitungTagihanListrik;
var
    subsidi: char; // apakah rumah bersubsidi
    daya: integer; // pilihan daya listrik
    tarif: real; // tarif per kWh
    pemakaian, totalTagihan: real;
begin
    write('APAKAH RUMAH ANDA BERSUBSIDI? (Y/N): ');
    readln(subsidi);

    // pilihan tarif berdasarkan subsidi
    if (subsidi = 'y') or (subsidi = 'Y') then
    begin
        writeln('PILIH DAYA LISTRIK RUMAH ANDA:');
        writeln('1. 450 VA (Rp 415/kWh)');
        writeln('2. 900 VA (Rp 605/kWh)');
        writeln('3. 900 VA RTM (Rp 1.352/kWh)');
        writeln('4. 1.300-2.200 VA (Rp 1.444,70/kWh)');
        writeln('5. 3.500 VA KE ATAS (Rp 1.699,53/kWh)');
        readln(daya);

        case daya of
            1: tarif := 415;
            2: tarif := 605;
            3: tarif := 1352;
            4: tarif := 1444.70;
            5: tarif := 1699.53;
        else
            begin
                writeln('PILIHAN TIDAK VALID.');
                exit;
            end;
        end;
    end
    else
    begin
        writeln('PILIH DAYA LISTRIK RUMAH ANDA:');
        writeln('1. 900 VA (Rp 1.352/kWh)');
        writeln('2. 1.300 VA (Rp 1.444,70/kWh)');
        writeln('3. 2.200 VA (Rp 1.444,70/kWh)');
        writeln('4. 3.500-5.500 VA (Rp 1.699,53/kWh)');
        writeln('5. 6.600 VA KE ATAS (Rp 1.699,53/kWh)');
        readln(daya);

        case daya of
            1: tarif := 1352;
            2, 3: tarif := 1444.70;
            4, 5: tarif := 1699.53;
        else
            begin
                writeln('PILIHAN TIDAK VALID.');
                exit;
            end;
        end;
    end;

    write('MASUKKAN JUMLAH PEMAKAIAN LISTRIK (KWH): ');
    readln(pemakaian);

    if pemakaian < 0 then
        writeln('PEMAKAIAN TIDAK BOLEH NEGATIF!')
    else
    begin
        totalTagihan := pemakaian * tarif;
        writeln('------------------------------------');
        writeln('PEMAKAIAN LISTRIK: ', pemakaian:0:2, ' KWH');
        writeln('TARIF PER KWH: RP ', tarif:0:2);
        writeln('TOTAL TAGIHAN LISTRIK: RP ', totalTagihan:0:2);
        writeln('------------------------------------');
    end;
end;

// program utama
var
    punyaAkun: char;
    pilihan: char;
    isLoggedIn: boolean;
begin
    clrscr; // membersihkan layar
    repeat
        writeln('SELAMAT DATANG DI PROGRAM HITUNG TAGIHAN LISTRIK');
        writeln('-----------------------------------------------');
        write('APAKAH ANDA SUDAH MEMILIKI AKUN? (Y/N): ');
        readln(punyaAkun);

        if (punyaAkun = 'n') or (punyaAkun = 'N') then
        begin
            daftarAkun(akun, jumlahAkun); // pendaftaran akun baru
            isLoggedIn := login(akun, jumlahAkun); // login setelah daftar
        end
        else if (punyaAkun = 'y') or (punyaAkun = 'Y') then
        begin
            if jumlahAkun = 0 then
            begin
                writeln('BELUM ADA AKUN YANG TERDAFTAR. SILAKAN DAFTAR AKUN TERLEBIH DAHULU.');
                continue; // mengulangi menu utama
            end
            else
                isLoggedIn := login(akun, jumlahAkun); // login jika akun ada
        end
        else
        begin
            writeln('PILIHAN TIDAK VALID. SILAKAN COBA LAGI.');
            continue;
        end;

        if isLoggedIn then
        begin
            clrscr;
            hitungTagihanListrik; // prosedur hitung tagihan listrik
        end;

        write('APAKAH ANDA INGIN MENGULANG PROGRAM? (Y/N): ');
        readln(pilihan);
    until (pilihan = 'n') or (pilihan = 'N');

    writeln('TERIMA KASIH TELAH MENGGUNAKAN PROGRAM INI.');
end.
