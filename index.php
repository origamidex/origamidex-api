<?php
// Roteamento simples baseado na URL
$request = $_SERVER['REQUEST_URI'];

// Define o cabeçalho como JSON para a rota de API
if ($request === '/api/status') {
    header('Content-Type: application/json');
    echo json_encode([
        "mensagem" => "Olá Mundo!",
        "timestamp" => date("Y-m-d H:i:s"),
        "projeto" => "Origamidex PHP"
    ]);
    exit;
}

// Rota padrão (Home)
echo "<h1>Olá Mundo! Origamidex PHP está online.</h1>";
