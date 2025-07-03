console.log("brand_autocomplete loaded");

let brandsCache = [];

const fetchBrands = async () => {
  if (brandsCache.length > 0) return brandsCache;

  try {
    const response = await fetch("/api/brands");
    const data = await response.json();
    brandsCache = data.brands.map(b => b.name);
    return brandsCache;
  } catch (error) {
    console.error("銘柄取得エラー", error);
    return [];
  }
};

document.addEventListener("turbo:load", () => {
  const input = document.getElementById("brand_name_input");
  const suggestionBox = document.getElementById("brand_suggestions");

  if (!input || !suggestionBox) return;

  input.addEventListener("input", async () => {
    const val = input.value.trim();
    suggestionBox.innerHTML = "";

    if (!val) {
      suggestionBox.classList.add("hidden");
      return;
    }

    const brands = await fetchBrands();
    const matches = brands.filter(b => b.includes(val)).slice(0, 10);

    if (matches.length === 0) {
      suggestionBox.classList.add("hidden");
      return;
    }

    matches.forEach(b => {
      const li = document.createElement("li");
      li.textContent = b;
      li.className = "px-4 py-2 hover:bg-yellow-200 cursor-pointer";
      li.addEventListener("click", () => {
        input.value = b;
        suggestionBox.classList.add("hidden");
      });
      suggestionBox.appendChild(li);
    });

    suggestionBox.classList.remove("hidden");
  });

  document.addEventListener("click", (e) => {
    if (!e.target.closest("#brand_name_input") && !e.target.closest("#brand_suggestions")) {
      suggestionBox.classList.add("hidden");
    }
  });
});
