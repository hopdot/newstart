<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Crypto Market Tracker</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 2rem; background: #f4f4f4; color: #333; }
    h1 { color: #2c3e50; }
    table { width: 100%; border-collapse: collapse; background: #fff; margin-top: 1rem; }
    th, td { padding: 1rem; border: 1px solid #ddd; text-align: left; }
    th { background: #2c3e50; color: white; }
  </style>
</head>
<body>
  <h1>Live Crypto Market Prices (CoinGecko)</h1>
  <table id="crypto-table">
    <thead>
      <tr>
        <th>Name</th>
        <th>Symbol</th>
        <th>Price (USD)</th>
        <th>24h Change</th>
      </tr>
    </thead>
    <tbody></tbody>
  </table>

  <script>
    async function fetchCryptoData() {
      const url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=false';
      const res = await fetch(url);
      const data = await res.json();

      const tbody = document.querySelector('#crypto-table tbody');
      tbody.innerHTML = ''; // clear any existing rows

      data.forEach(coin => {
        const row = document.createElement('tr');
        row.innerHTML = `
          <td>${coin.name}</td>
          <td>${coin.symbol.toUpperCase()}</td>
          <td>$${coin.current_price.toLocaleString()}</td>
          <td style="color:${coin.price_change_percentage_24h >= 0 ? 'green' : 'red'};">
            ${coin.price_change_percentage_24h.toFixed(2)}%
          </td>
        `;
        tbody.appendChild(row);
      });
    }

    fetchCryptoData();
    setInterval(fetchCryptoData, 60000); // refresh every 60 seconds
  </script>
</body>
</html>
