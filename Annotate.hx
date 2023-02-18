import haxeparser.Data.Token;
import haxeparser.HaxeLexer;
import byte.ByteData;


function build(code:String):Array<String> {
    var tokens:Array<Token> = [];
    var lexer = new HaxeLexer(byte.ByteData.ofString(code), "TokenStream");
    var t:Token = lexer.token(HaxeLexer.tok);
    while (t.tok != Eof) {
        tokens.push(t);
        t = lexer.token(haxeparser.HaxeLexer.tok);
    }
    final comments:Array<String> = [];
    var commentBefore = false;
    for (token in tokens) {
        switch token.tok {
            case CommentLine(s):
                if (commentBefore) {
                    comments[comments.length - 1] += "\n" + s;
                }else{
                    comments.push(s);
                }
                commentBefore = true;
            default:
                commentBefore = false;
        }
    }
    return comments;
}