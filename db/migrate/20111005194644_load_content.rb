# encoding:utf-8
class LoadContent < ActiveRecord::Migration
  def up
    # pages
    Page.create(url_name: '', cro_name: 'Početna', order_no: 1)
    Page.create(url_name: 'o_nama', cro_name: 'O Nama', order_no: 2)
    Page.create(url_name: 'slike', cro_name: 'Slike', order_no: 3)
    Page.create(url_name: 'video', cro_name: 'Video', order_no: 4)

    # intro
    Content.create(
      text: "# Capella juris\n\n" \
            "<img src='images/capella_juris.jpg' alt='Capella juris' />\n\n" \
            'Capella juris pjevački je zbor Pravnog fakulteta Sveučilišta u Zagrebu, a sastoji se od pedesetak studentica i studenata te prijatelja Pravnog fakulteta. Osnovan je u svibnju 2006. na inicijativu prof. **Ive Josipovića**, sadašnjeg predsjednika RH i prof. **Wolfganga Ruscha**, koji je zbor vodio prve dvije godine. Sadašnji dirigent je mladi maestro [Jurica Petar Petrač](o_nama#jurica). Zbor nastupa na svim manifestacijama Fakulteta, a iza zbora stoji sedam samostalnih koncerta i pet domaćih i inozemnih natjecanja na kojima zbor uvijek osvaja nagrade. Probe se obično održavaju svakog ponedjeljka i četvrtka u 19:30 na Gornjem gradu, [Ćirilometodska 4](http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=%C4%87irilometodska+4,+zagreb&aq=&sll=37.0625,-95.677068&sspn=44.928295,107.138672&ie=UTF8&hq=&hnear=%C4%86irilometodska+4,+Zagreb,+Croatia&ll=45.813808,15.978659&spn=0.004853,0.013078&z=17). Zbor je naravno i susret prijatelja i bogatstvo druženja, ukratko Capella juris je iskustvo za svakoga…',
      content_type: 'intro',
      page: '/')

    # sidebar
    Sidebar.create(
      video_title: 'Makedonska humoreska',
      video: '<iframe width="560" height="315" src="http://www.youtube.com/embed/FAi48kKVTS4?rel=0" frameborder="0" allowfullscreen></iframe>',
      audio_title: 'Makedonsko devojče',
      audio: 'makedonsko_devojce')

    # news
    Content.create(
      text: "Vijesti",
      content_type: 'news',
      page: '/')
    News.create(
      text: "# Misa Criolla\n\n" \
            "Ovaj petak. Majke mi, bolje vam je da budete tamo.",
      created_at: Date.today)
    News.create(
      text: "# Nema ipak nastupa\n\n" \
            "Trebali smo nastupati u crkvi sv. Mateja, ali su nam rekli da nas ne žele primiti. Točnije, rekli su: \"Slobodno si vi pjevajte negdje drugdje u nekom podrumčiću, jer nas ne može više boliti briga za vašu glupu Misu Criollu. Zapravo, iskreno, već nam vas je pun k****.\" Nismo baš sigurni što su mislili pod time...",
      created_at: Date.today)

    # content
    Content.create(
      text: "# Povijest zbora\n\n" \
            "<img src='images/povijest_zbora.jpg' alt='Povijest zbora' />\n\n" \
            "Capella juris je zbor Pravnog fakulteta Sveučilišta u Zagrebu, osnovan u svibnju 2006. na inicijativu prof. **Josipovića** i prof. **Wolfganga Ruscha**, koji je zbor vodio prve dvije godine. Repertoar zbora je raznolik te se sastoji od renesansnih madrigala do suvremene glazbe, od hrvatske i europske narodne glazbe do jazza.\n\n" \
            "Zbor se sastoji od 58 studentica, studenata i prijatelja Pravnog fakulteta Sveučilišta u Zagrebu te nastupa na promocijama diplomanata, ali i svim važnijim manifestacijama vezanim uz fakultet. Tako je, između ostalog, nastupao u Hrvatskom narodnom kazalištu prilikom obilježavanja 230 godina Pravnog fakulteta u Zagrebu, prilikom posjeta povjerenika Europske Unije za proširenje, gospodina Olia Rehna, te za Zakladu Zlatko Crnić u Hrvatskoj odvjetničkoj komori.\n\n" \
            "Iza Capelle juris stoji natjecanje i četiri vrlo uspješna samostalna koncerta.\n\n" \
            "Prvi, božićni koncert, “**Magnificat anima mea Dominum**”, uz pratnju Hrvatskog baroknog ansambla održan je 2006. koji je obuhvaćao barokne božićne skladbe. Sljedeće godine, 2007., održana su dva božićna koncerta, u Varaždinu i Zagrebu, pod nazivom “**Gloria in excelsis Deo**”, u pratnji gudačkog kvarteta Rucner, a sastojali su se od europske narodne božićne glazbe. Godine 2008. zbor je sudjelovao na 9. natjecanju amaterskih pjevačkih zborova u Zagrebu, gdje je u Hrvatskom glazbenom zavodu osvojio brončanu plaketu. 25. studenog 2008. zbor je održao i koncert “**Omnia vincit Amor!**”, svojevrsnu posvetu ljubavi kroz raznolike glazbene oblike, a mjesec dana kasnije sad već i tradicionalni, božićni koncert pod nazivom “**Bog se rodi v Vitliomi**”, koji se sastojao od niza (relativno nepoznatih) hrvatskih božićnih napjeva, uz gostovanje tenora Hrvoja Meštrova.\n\n" \
            "Voditelj zbora od 2008. godine je mlad i perspektivan prof. **Jurica Petar Petrač**.",
      content_type: 'content',
      page: '/o_nama')
    Content.create(
      text: "# Biografija dirigenta\n\n" \
            "<img src='images/biografija_dirigenta.jpg' alt='Jurica Petar Petrač' />\n\n" \
            "Jurica Petar Petrač, prof. (Zagreb, 1985.) se nakon završene opće gimnazije [Tituš Brezovački](http://www.gimnazija-osma-tbrezovackog-zg.skole.hr/) i srednje glazbene škole [Blagoje Bersa] upisuje na studij glazbene teorije Muzičke akademije Sveučilišta u Zagrebu, diplomiravši u veljači 2009. godine. Istovremeno upisuje i studij Povijesti umjetnosti te Etnologije i kulturne antropologije na Filozofskom fakultetu u Zagrebu. Sa 17 godina osniva i Mješoviti pjevački zbor “Capella miércoles”, koji djeluje u crkvi sv. Kvirina na Pantovčaku. Od 2008. godine, nakon prvobitnog pjevačkog sudjelovanja, postaje glazbeni voditelj zbora “Capella juris”, a od 2011. glazbeni voditelj oratorijskog zbora crkve sv. Marka u Zagrebu, “Cantores Sancti Marci”.",
      content_type: 'content',
      page: '/o_nama')
    Content.create(
      text: 'Članovi zbora',
      content_type: 'members',
      page: '/o_nama')
    Content.create(
      text: "# Aktivnosti\n\n" \
            "## 2011\n" \
            "- **Akademska donatorska večer** pod pokroviteljstvom predsjednika Republike Hrvatske, Ive Josipovića (17. siječnja, studentski Kampus na Borongaju, Zagreb)\n" \
            "- Nastup Capelle u ciklusu koncerata klasične glazbe “**Night in Paris**” (24. ožujka, mala dvorana Vatroslav Lisinski)\n" \
            "- **Rođendanski koncert** Capelle juris, francuske šansone skladatelja Ravel, Debussy i Poulenc (13. svibnja, Preporodna dvorana HAZU)\n\n" \
            "## 2010\n" \
            "- 10. Natjecanje pjevačkih zborova Zagreb 2010., Zagrebački glazbeni podij Centra za kulturu “Trešnjevka” (17. travnja, Koncertna dvorana Vatroslava Lisinskog, Zagreb) – SREBRNA PLAKETA\n" \
            "- “**Praga Cantat**”, Natjecanje pjevačkih zborova (27.10–31.10., Češka) – SREBRNA PLAKETA i POSEBNA NAGRADA ŽIRIJA ZA NAJBOLJU IZVEDBU SUVREMENE KOMPOZICIJE (I. Kuljerić, Crn-bel)\n" \
            "- **Svečana akademija** povodom 20. obljetnice donošenja Ustava Republike Hrvatske i 60. obljetnice potpisivanja Konvencije za zaštitu ljudskih prava i temeljnih sloboda, nastup Capelle juris (10. prosinca, Hrvatski sabor, Zagreb)\n" \
            "- “**Misa Criolla**”, božićni koncert Capelle juris uz gostovanje ansambla [Ayllu](http://fotozine.org/?knjiga=galerije&poglavlje=2601&list=14559&element=242906), klaviristice [Ive Ljubičić](http://www.miniature-piano.com/video/Iva+Ljubi%C4%8Di%C4%87/) i tenora [Domagoja Dorotića](http://www.hnk.hr/hr/opera/ansambl/solisti_opere/domagoj_dorotic) (21. prosinca, Crkva Sv. Katarine u Zagrebu)\n\n" \
            "## 2009\n" \
            "- “**Amans amens**”, svečani koncert povodom 3. rođendana Capelle juris (20. svibnja, muzej Mimara)\n" \
            "- **Smotra amaterskih zborova grada Zagreba** (24. svibnja, Dom kulture Prečko)\n" \
            "- Nastup Capelle juris na **Dobro jutro Hrvatska** (23. lipnja, studio HRT-a, Zagreb)\n" \
            "- **Ohrid Choir Festival**, natjecanje pjevačkih zborova (28.8–1.9., Makedonija) – BRONČANA PLAKETA\n" \
            "- Nastup u **Hrvatskoj odvjetničkoj komori** povodom predstavljanja knjige odvjetnika Srećka Ilića (12. studenog, Hrvatski odvjetnički dom, Zagreb)\n" \
            "- “**Ceremony of Carols**”, božićni koncert Capelle juris (21. prosinca, Crkva Sv. Franje Asiškog, Zagreb)\n\n" \
            "## 2008\n" \
            "- 9. **Natjecanje pjevačkih zborova** Zagreb, 2008., Podij zagrebačkih glazbenih amatera – BRONČANA PLAKETA (3. svibnja, Hrvatski glazbeni zavod, Zagreb)\n" \
            "- “**Omnia vincit amor**”, koncert Capelle juris (25. studenog, Preporodna dvorana HAZU)\n" \
            "- “**Bog se rodi v Vitliomi**”, 22. prosinca (Crkva Sv. Franje Asiškog)\n\n" \
            "## 2007\n" \
            "- Nastup Capelle juris na **svečanoj konferenciji** gdje je Olli Rehn, povjerenik za proširenje u Europskoj komisiji, održao predavanje “Generacija Europa: Regionalna konferencija mladih” (11. svibnja, Pravni fakultet, Zagreb)\n" \
            "- “**Advent u Varaždinu**”, koncert zbora Capella juris i [gudačkog kvarteta Rucner](http://www.rucner-string-quartet.com/) (18. prosinca, crkva Sv. Nikole, Varaždin)\n" \
            "- “**Gloria in excelsis Deo**”, europska glazba za Božić, Capella juris i gudački kvartet Rucner (19. prosinca, crkva Sv. Franje Asiškog u Zagrebu)\n\n" \
            "## 2006\n" \
            "- Nastup na svečanosti obilježavanja **230 godina Pravnog fakulteta** Sveučilišta u Zagrebu (6. studenog, HNK Zagreb)\n" \
            "- “**Magnificat anima mea dominum!**”, koncert Capelle juris uz pratnju [Hrvatskog baroknog ansambla](http://www.hrba.hr/hr/) (21. prosinca, Crkva Sv. Franje Asiškog, Zagreb)",
      content_type: 'content',
      page: '/o_nama')

    # members
    ['Alisa Besek','Ana Miletić','Ana Vlašić','Ana Zavada','Anja Juršetić','Barbara Bogojević','Daria Dubajić','Ines Malenica','Ivana Peulić','Ivana Radman','Katarina Sabljić','Klara Marinčević','Kristina Gotvald','Lidija Živković','Marija Ercegovac','Marija Vučurević','Mia Nazalević','Mirjana Vladić','Nikolina Hržina','Veronika Veršić','Vesna Juretić','Vinka Lozica','Zrinka Marija Krnjak'].each do |member|
      Member.create(
        first_name: member.split(' ').first,
        last_name: member.split(' ').last,
        voice: 'S')
    end
    ['Ana Lukac','Ana Mažuranić','Ana Zidar','Barbara Pavlek','Daria Kolezarić','Darja Petro','Dina Jularić','Ingrid Marman','Iva Bojanovsky','Jelena Pepelnik','Lucija Petrač','Mirjana Martinković','Mirna Radosavljević','Nikol Namjesnik','Nikolina Zlopaša','Rafaela Tripalo','Valentina Samardžija','Vida Brezak'].each do |member|
      Member.create(
        first_name: member.split(' ').first,
        last_name: member.split(' ').last,
        voice: 'A')
    end
    ['Bartul Marušić','Davor Krnjak','Davor Kutnjak','Matija Marohnić','Tomislav Krnjak','Vedran Klisarić'].each do |member|
      Member.create(
        first_name: member.split(' ').first,
        last_name: member.split(' ').last,
        voice: 'T')
    end
    ['Dragutin Brezak','Emil Rekić','Emilio Nuić','Ivan Fabris','Juraj Gorupec','Jure Perić','Marko Ivanov','Nino Kovačić','Petar Brkić','Roko Perić','Tomislav Miljak','Vlaho Komparak'].each do |member|
      Member.create(
        first_name: member.split(' ').first,
        last_name: member.split(' ').last,
        voice: 'B')
    end

    # videos
    Video.create(
      title: 'Ohridski zborski festival – Makedonska humoreska',
      url: "<iframe allowfullscreen='allowfullscreen' frameborder='0' height='349' src='http://www.youtube.com/embed/FAi48kKVTS4' title='YouTube video player' width='560'></iframe>")
    Video.create(
      title: "Dobro jutro Hrvatska – Čardaš iz Međimurja",
      url: "<iframe allowfullscreen='allowfullscreen' frameborder='0' height='349' src='http://www.youtube.com/embed/70aYBGv0rhU' title='YouTube video player' width='425'></iframe>")
    Video.create(
      title: "Nastup u Hrvatskom Saboru",
      url: "<iframe allowfullscreen='allowfullscreen' frameborder='0' height='349' src='http://www.youtube.com/embed/wzpqKWEn_v0' title='YouTube video player' width='425'></iframe>")
    Video.create(
      title: "Promocija u Lisinskom – U boj, u boj!",
      url: "<iframe allowfullscreen='allowfullscreen' frameborder='0' height='349' src='http://www.youtube.com/embed/SGEXnxxH4GM' title='YouTube video player' width='560'></iframe>")
    Video.create(
      title: "10. natjecanje zborova – Jesu dulcis",
      url: "<iframe allowfullscreen='allowfullscreen' frameborder='0' height='349' src='http://www.youtube.com/embed/lcq21Oe0iQA' title='YouTube video player' width='560'></iframe>")
    Video.create(
      title: "Praga Cantat – Napadly pisne",
      url: "<iframe allowfullscreen='allowfullscreen' frameborder='0' height='349' src='http://www.youtube.com/embed/jxjufTatTec' title='YouTube video player' width='560'></iframe>")
    Video.create(
      title: "Misa Criolla – La peregriacion",
      url: "<iframe allowfullscreen='allowfullscreen' frameborder='0' height='349' src='http://www.youtube.com/embed/kG2Ww4baGyo' title='YouTube video player' width='560'></iframe>")
    Video.create(
      title: "Misa Criolla – Gloria",
      url: "<iframe allowfullscreen='allowfullscreen' frameborder='0' height='349' src='http://www.youtube.com/embed/Bo3OhSP6OW8' title='YouTube video player' width='560'></iframe>")
  end

  def down
    Content.delete_all; Member.delete_all; News.delete_all
    Page.delete_all; Sidebar.delete_all; Video.delete_all
  end
end
