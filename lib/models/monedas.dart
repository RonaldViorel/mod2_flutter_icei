

class Monedas {
    final String aud;
    final String bgn;
    final String brl;
    final String cad;
    final String chf;
    final String cny;
    final String czk;
    final String dkk;
    final String eur;
    final String gbp;
    final String hkd;
    final String huf;
    final String idr;
    final String ils;
    final String inr;
    final String isk;
    final String jpy;
    final String krw;
    final String mxn;
    final String myr;
    final String nok;
    final String nzd;
    final String php;
    final String pln;
    final String ron;
    final String sek;
    final String sgd;
    final String thb;
    final String monedasTry;
    final String usd;
    final String zar;

    Monedas({
        required this.aud,
        required this.bgn,
        required this.brl,
        required this.cad,
        required this.chf,
        required this.cny,
        required this.czk,
        required this.dkk,
        required this.eur,
        required this.gbp,
        required this.hkd,
        required this.huf,
        required this.idr,
        required this.ils,
        required this.inr,
        required this.isk,
        required this.jpy,
        required this.krw,
        required this.mxn,
        required this.myr,
        required this.nok,
        required this.nzd,
        required this.php,
        required this.pln,
        required this.ron,
        required this.sek,
        required this.sgd,
        required this.thb,
        required this.monedasTry,
        required this.usd,
        required this.zar,
    });

    factory Monedas.fromJson(Map<String, dynamic> json) => Monedas(
        aud: json["AUD"],
        bgn: json["BGN"],
        brl: json["BRL"],
        cad: json["CAD"],
        chf: json["CHF"],
        cny: json["CNY"],
        czk: json["CZK"],
        dkk: json["DKK"],
        eur: json["EUR"],
        gbp: json["GBP"],
        hkd: json["HKD"],
        huf: json["HUF"],
        idr: json["IDR"],
        ils: json["ILS"],
        inr: json["INR"],
        isk: json["ISK"],
        jpy: json["JPY"],
        krw: json["KRW"],
        mxn: json["MXN"],
        myr: json["MYR"],
        nok: json["NOK"],
        nzd: json["NZD"],
        php: json["PHP"],
        pln: json["PLN"],
        ron: json["RON"],
        sek: json["SEK"],
        sgd: json["SGD"],
        thb: json["THB"],
        monedasTry: json["TRY"],
        usd: json["USD"],
        zar: json["ZAR"],
    );

    Map<String, dynamic> toJson() => {
        "AUD": aud,
        "BGN": bgn,
        "BRL": brl,
        "CAD": cad,
        "CHF": chf,
        "CNY": cny,
        "CZK": czk,
        "DKK": dkk,
        "EUR": eur,
        "GBP": gbp,
        "HKD": hkd,
        "HUF": huf,
        "IDR": idr,
        "ILS": ils,
        "INR": inr,
        "ISK": isk,
        "JPY": jpy,
        "KRW": krw,
        "MXN": mxn,
        "MYR": myr,
        "NOK": nok,
        "NZD": nzd,
        "PHP": php,
        "PLN": pln,
        "RON": ron,
        "SEK": sek,
        "SGD": sgd,
        "THB": thb,
        "TRY": monedasTry,
        "USD": usd,
        "ZAR": zar,
    };
}
