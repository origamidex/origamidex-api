var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// O famoso "Olá Mundo" no GET
app.MapGet("/", () => "Olá Mundo! Origamidex está online.");

// Exemplo de retorno em JSON (padrão de APIs)
app.MapGet("/api/status", () => new { 
    mensagem = "Olá Mundo!", 
    timestamp = DateTime.Now,
    projeto = "Origamidex"
});

app.Run();
