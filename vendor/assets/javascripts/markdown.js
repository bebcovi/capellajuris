/**
 *  Markdown Language Definition
 *  
 *  A language definition for string manipulation operations, in this case 
 *  for the Markdown, uh, markup language. Uses regexes for various functions
 *  by default. If regexes won't do and you need to do some serious 
 *  manipulation, you can declare a function in the object instead.
 *
 *  Code example:
 *  'functionbar-id'  :   {
 *                          exec: function(text, selectedText) {
 *                                   functionStuffHere();
 *                                },
 *                          search: /somesearchregex/gi,
 *                          replace: 'replace text for RegExp.replace',
 *                          append: "just add this where the cursor is"
 *                         }  
 *
**/
(function() {

var MarkDown = {
  
  'function-bold' :         {
                              search: /([^\n]+)([\n\s]*)/g,
                              replace: "**$1**$2"
                            },
  
  'function-italic' :       {
                              search: /([^\n]+)([\n\s]*)/g,
                              replace: "_$1_$2"
                            },
  
  'function-code'   :       {
                              search: /(^[\n]+)([\n\s]*)/g,
                              replace: "`$1`$2"
                            },
                            
  'function-hr'     :       {
                              append: "\n***\n"
                            },
  
  'function-ul'     :       { 
                              search: /(.+)([\n]?)/g,
                              replace: "* $1$2"
                            },
  
  /* This looks silly but is completely valid Markdown */                     
  'function-ol'   :         {
                              search: /(.+)([\n]?)/g,
                              replace: "1. $1$2"
                            },
                            
  'function-blockquote' :   {
                              search: /(.+)([\n]?)/g,
                              replace: "> $1$2"
                            }, 
                            
  'function-h1'         :   {
                              search: /(.+)([\n]?)/g,
                              replace: "# $1$2"
                            },
                            
  'function-h2'         :   {
                              search: /(.+)([\n]?)/g,
                              replace: "## $1$2"
                            },
                            
  'function-h3'         :   {
                              search: /(.+)([\n]?)/g,
                              replace: "### $1$2"
                            },
                            
  'function-link'       :   {
                              exec: function( txt, selText, $field ) {
                                var results = null;
                                $.GollumEditor.Dialog.init({
                                  title: 'Insert Link',
                                  fields: [
                                    {
                                      id:   'text',
                                      name: 'Link Text',
                                      type: 'text'
                                    },
                                    {
                                      id:   'href',
                                      name: 'URL',
                                      type: 'text'
                                    }
                                  ],
                                  OK: function( res ) {
                                   var rep = '';
                                   if ( res['text'] && res['href'] ) {
                                      rep = '[' + res['text'] + '](' 
                                             + res['href'] + ')';
                                    }
                                    $.GollumEditor.replaceSelection( rep );
                                  }
                                }); 
                              }
                            },
                     
  'function-image'      :   {
                              exec: function( txt, selText, $field ) {
                                var results = null;
                                $.GollumEditor.Dialog.init({
                                  title: 'Insert Image',
                                  fields: [
                                    {
                                      id: 'url',
                                      name: 'Image URL',
                                      type: 'text'
                                    },
                                    {
                                      id: 'alt',
                                      name: 'Alt Text',
                                      type: 'text'
                                    }
                                  ],
                                  OK: function( res ) {
                                    var rep = '';
                                    if ( res['url'] && res['alt'] ) {
                                      rep = '![' + res['alt'] + ']' +
                                            '(' + res['url'] + ')';
                                    }
                                    $.GollumEditor.replaceSelection( rep );
                                  }
                                });
                              }
                            }
                            
};

var MarkDownHelp = [

  {
    menuName: 'Markdown',
    content: [
                {
                  menuName: 'Uvod',
                  data: '<p>Jezik kojeg ovaj editor koristi zove se <strong>Markdown</strong>. Sastoji se od jednostavnih oznaka koje omogućavaju bold, italic, dodavanje lista, linkova i sl. Ovaj editor može mnogo više od onoga što je dokumentirano, ali je suvišna funkcionalnost uklonjena radi preglednosti.</p>'
                },

                {
                  menuName: 'Naglasci',
                  data: '<p>Markdown ima po dva načina za opisivanje svake vrste naglaska. Jednostruke zvjezdice (*) i povlake (_) se interpretiraju kao <em>italic</em>, dok duple zvjeznice (**) i povlake (__) čine <strong>bold</strong>. Npr. *Ovaj tekst* postaje <em>Ovaj tekst</em>, a __Ovaj tekst__ postaje <strong>Ovaj tekst</strong>.</p>'
                },

                {
                  menuName: 'Liste',
                  data: '<p>Postoje 2 tipa liste, onaj gdje je redoslijed bitan (brojke) i onaj gdje redoslijed nije bitan (točkice). Za prvi tip se koriste brojke (bilo koje, zato editor koristi samo jedinice), a za drugi se mogu koristiti crtice (-), zvjezdice (*) ili plusevi (+). Npr. ovaj zapis:</p><p>1. staviti vodu u lonac<br>1. upaliti vatru na štednjaku<br>1. staviti lonac na vatru</p><p>rezultira ovakvom listom:</p><p><ol><li>staviti vodu u lonac</li><li>upaliti vatru na štednjaku</li><li>staviti lonac na vatru</li></ol></p><p>A ovaj zapis:</p><p>* cipele<br>* jakna<br>* hlače</p><p>ispisuje ovakvu listu:</p><ul><li>cipele</li><li>jakna</li><li>hlače</li></ul>'
                },

                {
                  menuName: 'Citati',
                  data: '<p>Citati se rade tako da se na početku linije dodaje otvorena uglata zagrada. Npr. ovaj zapis:</p><p>&gt; Bolje vrabac u ruci nego golub na grani.</p><p>se ovako ispisuje:</p><blockquote><p>Bolje vrabac u ruci nego golub na grani.</p></blockquote>'
                },

                {
                  menuName: 'Linkovi',
                  data: '<p>Link se radi tako da se unutar uglatih zagrada stavlja naziv linka, odnosno ono što korisnik vidi, a unutar oblih zagrada stavlja se s&acirc;m link. Npr. [Ovaj link](http://capellajuris.hr/) postaje <a href="http://capellajuris.hr/">Ovaj link</a>.</p>'
                }

              ]
  }
];


jQuery.GollumEditor.defineLanguage('markdown', MarkDown);
jQuery.GollumEditor.defineHelp('markdown', MarkDownHelp);

})();
