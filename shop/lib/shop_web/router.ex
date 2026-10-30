defmodule ShopWeb.Router do
  use ShopWeb, :router

  import ShopWeb.UserAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {ShopWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fetch_current_scope_for_user)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ShopWeb do
    pipe_through(:browser)

    get("/", PageController, :home)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShopWeb do
  #   pipe_through :api
  # end

  ## Authentication routes

  scope "/", ShopWeb do
    pipe_through([:browser, :require_authenticated_user])

    live_session :require_authenticated_user,
      on_mount: [{ShopWeb.UserAuth, :require_authenticated}] do
      live("/catalog_alphas", CatalogAlphaLive.Index, :index)
      live("/catalog_alphas/new", CatalogAlphaLive.Form, :new)
      live("/catalog_alphas/:id", CatalogAlphaLive.Show, :show)
      live("/catalog_alphas/:id/edit", CatalogAlphaLive.Form, :edit)
      live("/catalog_bravos", CatalogBravoLive.Index, :index)
      live("/catalog_bravos/new", CatalogBravoLive.Form, :new)
      live("/catalog_bravos/:id", CatalogBravoLive.Show, :show)
      live("/catalog_bravos/:id/edit", CatalogBravoLive.Form, :edit)
      live("/catalog_charlies", CatalogCharlieLive.Index, :index)
      live("/catalog_charlies/new", CatalogCharlieLive.Form, :new)
      live("/catalog_charlies/:id", CatalogCharlieLive.Show, :show)
      live("/catalog_charlies/:id/edit", CatalogCharlieLive.Form, :edit)
      live("/catalog_deltas", CatalogDeltaLive.Index, :index)
      live("/catalog_deltas/new", CatalogDeltaLive.Form, :new)
      live("/catalog_deltas/:id", CatalogDeltaLive.Show, :show)
      live("/catalog_deltas/:id/edit", CatalogDeltaLive.Form, :edit)
      live("/catalog_echos", CatalogEchoLive.Index, :index)
      live("/catalog_echos/new", CatalogEchoLive.Form, :new)
      live("/catalog_echos/:id", CatalogEchoLive.Show, :show)
      live("/catalog_echos/:id/edit", CatalogEchoLive.Form, :edit)
      live("/sales_alphas", SalesAlphaLive.Index, :index)
      live("/sales_alphas/new", SalesAlphaLive.Form, :new)
      live("/sales_alphas/:id", SalesAlphaLive.Show, :show)
      live("/sales_alphas/:id/edit", SalesAlphaLive.Form, :edit)
      live("/sales_bravos", SalesBravoLive.Index, :index)
      live("/sales_bravos/new", SalesBravoLive.Form, :new)
      live("/sales_bravos/:id", SalesBravoLive.Show, :show)
      live("/sales_bravos/:id/edit", SalesBravoLive.Form, :edit)
      live("/sales_charlies", SalesCharlieLive.Index, :index)
      live("/sales_charlies/new", SalesCharlieLive.Form, :new)
      live("/sales_charlies/:id", SalesCharlieLive.Show, :show)
      live("/sales_charlies/:id/edit", SalesCharlieLive.Form, :edit)
      live("/sales_deltas", SalesDeltaLive.Index, :index)
      live("/sales_deltas/new", SalesDeltaLive.Form, :new)
      live("/sales_deltas/:id", SalesDeltaLive.Show, :show)
      live("/sales_deltas/:id/edit", SalesDeltaLive.Form, :edit)
      live("/sales_echos", SalesEchoLive.Index, :index)
      live("/sales_echos/new", SalesEchoLive.Form, :new)
      live("/sales_echos/:id", SalesEchoLive.Show, :show)
      live("/sales_echos/:id/edit", SalesEchoLive.Form, :edit)
      live("/support_alphas", SupportAlphaLive.Index, :index)
      live("/support_alphas/new", SupportAlphaLive.Form, :new)
      live("/support_alphas/:id", SupportAlphaLive.Show, :show)
      live("/support_alphas/:id/edit", SupportAlphaLive.Form, :edit)
      live("/support_bravos", SupportBravoLive.Index, :index)
      live("/support_bravos/new", SupportBravoLive.Form, :new)
      live("/support_bravos/:id", SupportBravoLive.Show, :show)
      live("/support_bravos/:id/edit", SupportBravoLive.Form, :edit)
      live("/support_charlies", SupportCharlieLive.Index, :index)
      live("/support_charlies/new", SupportCharlieLive.Form, :new)
      live("/support_charlies/:id", SupportCharlieLive.Show, :show)
      live("/support_charlies/:id/edit", SupportCharlieLive.Form, :edit)
      live("/support_deltas", SupportDeltaLive.Index, :index)
      live("/support_deltas/new", SupportDeltaLive.Form, :new)
      live("/support_deltas/:id", SupportDeltaLive.Show, :show)
      live("/support_deltas/:id/edit", SupportDeltaLive.Form, :edit)
      live("/support_echos", SupportEchoLive.Index, :index)
      live("/support_echos/new", SupportEchoLive.Form, :new)
      live("/support_echos/:id", SupportEchoLive.Show, :show)
      live("/support_echos/:id/edit", SupportEchoLive.Form, :edit)
      live("/inventory_alphas", InventoryAlphaLive.Index, :index)
      live("/inventory_alphas/new", InventoryAlphaLive.Form, :new)
      live("/inventory_alphas/:id", InventoryAlphaLive.Show, :show)
      live("/inventory_alphas/:id/edit", InventoryAlphaLive.Form, :edit)
      live("/inventory_bravos", InventoryBravoLive.Index, :index)
      live("/inventory_bravos/new", InventoryBravoLive.Form, :new)
      live("/inventory_bravos/:id", InventoryBravoLive.Show, :show)
      live("/inventory_bravos/:id/edit", InventoryBravoLive.Form, :edit)
      live("/inventory_charlies", InventoryCharlieLive.Index, :index)
      live("/inventory_charlies/new", InventoryCharlieLive.Form, :new)
      live("/inventory_charlies/:id", InventoryCharlieLive.Show, :show)
      live("/inventory_charlies/:id/edit", InventoryCharlieLive.Form, :edit)
      live("/inventory_deltas", InventoryDeltaLive.Index, :index)
      live("/inventory_deltas/new", InventoryDeltaLive.Form, :new)
      live("/inventory_deltas/:id", InventoryDeltaLive.Show, :show)
      live("/inventory_deltas/:id/edit", InventoryDeltaLive.Form, :edit)
      live("/inventory_echos", InventoryEchoLive.Index, :index)
      live("/inventory_echos/new", InventoryEchoLive.Form, :new)
      live("/inventory_echos/:id", InventoryEchoLive.Show, :show)
      live("/inventory_echos/:id/edit", InventoryEchoLive.Form, :edit)
      live("/crm_alphas", CrmAlphaLive.Index, :index)
      live("/crm_alphas/new", CrmAlphaLive.Form, :new)
      live("/crm_alphas/:id", CrmAlphaLive.Show, :show)
      live("/crm_alphas/:id/edit", CrmAlphaLive.Form, :edit)
      live("/crm_bravos", CrmBravoLive.Index, :index)
      live("/crm_bravos/new", CrmBravoLive.Form, :new)
      live("/crm_bravos/:id", CrmBravoLive.Show, :show)
      live("/crm_bravos/:id/edit", CrmBravoLive.Form, :edit)
      live("/crm_charlies", CrmCharlieLive.Index, :index)
      live("/crm_charlies/new", CrmCharlieLive.Form, :new)
      live("/crm_charlies/:id", CrmCharlieLive.Show, :show)
      live("/crm_charlies/:id/edit", CrmCharlieLive.Form, :edit)
      live("/crm_deltas", CrmDeltaLive.Index, :index)
      live("/crm_deltas/new", CrmDeltaLive.Form, :new)
      live("/crm_deltas/:id", CrmDeltaLive.Show, :show)
      live("/crm_deltas/:id/edit", CrmDeltaLive.Form, :edit)
      live("/crm_echos", CrmEchoLive.Index, :index)
      live("/crm_echos/new", CrmEchoLive.Form, :new)
      live("/crm_echos/:id", CrmEchoLive.Show, :show)
      live("/crm_echos/:id/edit", CrmEchoLive.Form, :edit)
      live("/billing_alphas", BillingAlphaLive.Index, :index)
      live("/billing_alphas/new", BillingAlphaLive.Form, :new)
      live("/billing_alphas/:id", BillingAlphaLive.Show, :show)
      live("/billing_alphas/:id/edit", BillingAlphaLive.Form, :edit)
      live("/billing_bravos", BillingBravoLive.Index, :index)
      live("/billing_bravos/new", BillingBravoLive.Form, :new)
      live("/billing_bravos/:id", BillingBravoLive.Show, :show)
      live("/billing_bravos/:id/edit", BillingBravoLive.Form, :edit)
      live("/billing_charlies", BillingCharlieLive.Index, :index)
      live("/billing_charlies/new", BillingCharlieLive.Form, :new)
      live("/billing_charlies/:id", BillingCharlieLive.Show, :show)
      live("/billing_charlies/:id/edit", BillingCharlieLive.Form, :edit)
      live("/billing_deltas", BillingDeltaLive.Index, :index)
      live("/billing_deltas/new", BillingDeltaLive.Form, :new)
      live("/billing_deltas/:id", BillingDeltaLive.Show, :show)
      live("/billing_deltas/:id/edit", BillingDeltaLive.Form, :edit)
      live("/billing_echos", BillingEchoLive.Index, :index)
      live("/billing_echos/new", BillingEchoLive.Form, :new)
      live("/billing_echos/:id", BillingEchoLive.Show, :show)
      live("/billing_echos/:id/edit", BillingEchoLive.Form, :edit)
      live("/events_alphas", EventsAlphaLive.Index, :index)
      live("/events_alphas/new", EventsAlphaLive.Form, :new)
      live("/events_alphas/:id", EventsAlphaLive.Show, :show)
      live("/events_alphas/:id/edit", EventsAlphaLive.Form, :edit)
      live("/events_bravos", EventsBravoLive.Index, :index)
      live("/events_bravos/new", EventsBravoLive.Form, :new)
      live("/events_bravos/:id", EventsBravoLive.Show, :show)
      live("/events_bravos/:id/edit", EventsBravoLive.Form, :edit)
      live("/events_charlies", EventsCharlieLive.Index, :index)
      live("/events_charlies/new", EventsCharlieLive.Form, :new)
      live("/events_charlies/:id", EventsCharlieLive.Show, :show)
      live("/events_charlies/:id/edit", EventsCharlieLive.Form, :edit)
      live("/events_deltas", EventsDeltaLive.Index, :index)
      live("/events_deltas/new", EventsDeltaLive.Form, :new)
      live("/events_deltas/:id", EventsDeltaLive.Show, :show)
      live("/events_deltas/:id/edit", EventsDeltaLive.Form, :edit)
      live("/events_echos", EventsEchoLive.Index, :index)
      live("/events_echos/new", EventsEchoLive.Form, :new)
      live("/events_echos/:id", EventsEchoLive.Show, :show)
      live("/events_echos/:id/edit", EventsEchoLive.Form, :edit)
      live("/content_alphas", ContentAlphaLive.Index, :index)
      live("/content_alphas/new", ContentAlphaLive.Form, :new)
      live("/content_alphas/:id", ContentAlphaLive.Show, :show)
      live("/content_alphas/:id/edit", ContentAlphaLive.Form, :edit)
      live("/content_bravos", ContentBravoLive.Index, :index)
      live("/content_bravos/new", ContentBravoLive.Form, :new)
      live("/content_bravos/:id", ContentBravoLive.Show, :show)
      live("/content_bravos/:id/edit", ContentBravoLive.Form, :edit)
      live("/content_charlies", ContentCharlieLive.Index, :index)
      live("/content_charlies/new", ContentCharlieLive.Form, :new)
      live("/content_charlies/:id", ContentCharlieLive.Show, :show)
      live("/content_charlies/:id/edit", ContentCharlieLive.Form, :edit)
      live("/content_deltas", ContentDeltaLive.Index, :index)
      live("/content_deltas/new", ContentDeltaLive.Form, :new)
      live("/content_deltas/:id", ContentDeltaLive.Show, :show)
      live("/content_deltas/:id/edit", ContentDeltaLive.Form, :edit)
      live("/content_echos", ContentEchoLive.Index, :index)
      live("/content_echos/new", ContentEchoLive.Form, :new)
      live("/content_echos/:id", ContentEchoLive.Show, :show)
      live("/content_echos/:id/edit", ContentEchoLive.Form, :edit)
      live("/users/settings", UserLive.Settings, :edit)
      live("/users/settings/confirm-email/:token", UserLive.Settings, :confirm_email)
    end

    post("/users/update-password", UserSessionController, :update_password)
  end

  scope "/", ShopWeb do
    pipe_through([:browser])

    live_session :current_user,
      on_mount: [{ShopWeb.UserAuth, :mount_current_scope}] do
      live("/users/register", UserLive.Registration, :new)
      live("/users/log-in", UserLive.Login, :new)
      live("/users/log-in/:token", UserLive.Confirmation, :new)
    end

    post("/users/log-in", UserSessionController, :create)
    delete("/users/log-out", UserSessionController, :delete)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:shop, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: ShopWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
