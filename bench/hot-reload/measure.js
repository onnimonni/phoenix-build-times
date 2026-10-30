// Save -> screen latency of a LiveView template edit, as a Playwright function
// (paste into a Playwright runner that passes `page`, e.g. the Playwright MCP
// server's run_code tool). Needs `mix phx.server` on :4000 and
// bench/hot-reload/editor.exs on :4999.
//
// A MutationObserver installed in every document timestamps the moment the
// marker appears, so the result does not depend on Playwright's polling and
// survives full page reloads.
async (page) => {
  await page.addInitScript(() => {
    const check = () => {
      const marker = sessionStorage.getItem("hrMarker")
      if (marker && !sessionStorage.getItem("hrSeen") && document.body?.innerText.includes(marker)) {
        sessionStorage.setItem("hrSeen", String(Date.now()))
      }
    }
    new MutationObserver(check).observe(document, { childList: true, subtree: true, characterData: true })
    document.addEventListener("DOMContentLoaded", check)
  })

  await page.goto("http://127.0.0.1:4000/users/log-in")
  await page.waitForSelector("[data-phx-main].phx-connected")
  await page.waitForTimeout(1500)

  const results = []
  let fullPageReloads = 0
  page.on("framenavigated", (frame) => { if (frame === page.mainFrame()) fullPageReloads++ })

  for (let i = 0; i < 15; i++) {
    const marker = `HR${Date.now()}`
    await page.evaluate((m) => { sessionStorage.setItem("hrMarker", m); sessionStorage.removeItem("hrSeen") }, marker)
    const start = Date.now()
    await page.request.get(`http://127.0.0.1:4999/edit/${marker}`)

    let seen = null
    for (let k = 0; k < 300 && !seen; k++) {
      await page.waitForTimeout(25)
      try { seen = await page.evaluate(() => sessionStorage.getItem("hrSeen")) } catch (_) {}
    }

    results.push(seen ? Number(seen) - start : -1)
    await page.waitForSelector("[data-phx-main].phx-connected")
    await page.waitForTimeout(1200)
  }

  await page.request.get("http://127.0.0.1:4999/restore")
  const sorted = [...results].sort((a, b) => a - b)
  return { results, median: sorted[Math.floor(sorted.length / 2)], fullPageReloads }
}
