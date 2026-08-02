# 07 — Subscription & Revenue Model

**Document ID:** PRD-07  
**Currency:** INR  
**Related:** BR-SUB-*, FR-SUB-*, FR-SETL-*, FR-COUP-*

> Pricing numbers below are **placeholders** for planning. Founders must approve list prices before public launch (see open questions).

---

## 1. Commercial thesis

BookMySpace monetizes both sides carefully:

1. **Owner SaaS subscriptions** — predictable revenue for OS features.
2. **Marketplace take-rate** — commission on successfully paid bookings.
3. **Liquidity boosters** — featured listings, ads, coupons credits.
4. **Adjacent** — vendor marketplace commission, website builder / white-label, API access (Enterprise).

India-first payment collection via **Razorpay** (UPI-heavy).

---

## 2. Subscription plans comparison

| Feature | Free | Starter | Professional | Enterprise |
|---------|------|---------|--------------|------------|
| **Indicative price** | ₹0 | ₹999/mo | ₹2,999/mo | Custom |
| Venues | 1 | 3 | 10 | Unlimited / contract |
| Staff seats | 1 (owner) | 3 | 10 | Custom |
| Inventory units | Unlimited within venue | Same | Same | Same |
| Photos / venue | 10 | 25 | 50 | Custom + video |
| Booking + calendar | Yes | Yes | Yes | Yes |
| Instant + request modes | Yes | Yes | Yes | Yes |
| Online payments | Yes | Yes | Yes | Yes |
| Basic email/push notify | Yes | Yes | Yes | Yes |
| WhatsApp templates | Limited | Standard | Standard + digests | Custom |
| Owner coupons | — | Yes | Yes | Yes |
| CRM notes | — | Basic | Advanced + segments | Advanced |
| Reports & CSV export | Summary only | Yes | Advanced | Custom BI export |
| Featured listing credits / mo | 0 | 1 | 5 | Custom |
| Vendor marketplace access | — | — | Yes | Yes |
| Multi-city SEO landing assist | — | — | Yes | Yes |
| Website builder / branded page | — | — | Add-on | Included |
| White-label | — | — | — | Yes |
| Public API access | — | — | — | Yes |
| Franchise rollup | — | — | — | Yes |
| SLA / SSO / dedicated support | — | — | Email SLA | Custom |
| Marketplace commission | Standard | Standard | Discounted | Negotiated |

---

## 3. Upgrade / downgrade rules

| Action | Rule |
|--------|------|
| Upgrade | Immediate entitlements; billing prorated (recommended) or charge full cycle (founder choice) |
| Downgrade | Effective next billing period end by default |
| Over-limit on downgrade | Block until venues/staff/media within new caps |
| Annual prepay | Discount (e.g., 2 months free) — optional |
| Trial | 14-day Professional trial for new orgs (flag) |
| Failed payment | 7-day grace → freeze publish/featured; bookings honored |
| Cancel subscription | Revert to Free at period end; data retained per retention policy |

---

## 4. Revenue streams

### 4.1 Matrix

| Stream | Who pays | When | MVP? | Notes |
|--------|----------|------|------|-------|
| Subscription | Owner org | Monthly/annual | V1 | Core SaaS |
| Booking commission | Owner (deducted) or built into fee | Per confirmed paid booking | MVP/V1 | Category-specific % |
| Featured listings | Owner | Per credit / auction later | V1 | Search boost |
| Ads / banners | Advertisers / owners | Campaign | V2 | CMS placements |
| Vendor marketplace commission | Vendor | Per paid vendor job | V2/V3 | Attach to bookings |
| Payment convenience fee | Customer (optional) | Per txn | Decision needed | Prefer avoid if take-rate healthy |
| Website builder | Owner | Subscription add-on | V2 | Branded microsite |
| White-label | Enterprise | Contract | Enterprise | Custom domain |
| API access | Enterprise | Contract | Enterprise | Rate-limited |
| Franchise fees | Partner | Contract | Enterprise | Rollup + branding |
| Premium support | Owner | Add-on | V2 | Faster SLA |

### 4.2 Indicative commission defaults (placeholders)

| Category cluster | Standard take-rate | Professional discount | Enterprise |
|------------------|--------------------|----------------------|------------|
| Banquet / events | 8% | 6% | Negotiated |
| Meeting rooms | 10% | 8% | Negotiated |
| Sports hourly | 12% | 10% | Negotiated |
| Training | 8% | 6% | Negotiated |
| Coworking passes | 10% | 8% | Negotiated |
| Vendor jobs | 15% | 12% | Negotiated |

---

## 5. Unit economics (planning model)

```text
Net revenue ≈ Σ(subscriptions) + Σ(commission on GMV) + Σ(featured/ads) + Σ(vendor take)
             − payment gateway fees − WhatsApp/SMS − cloud − support − refunds/chargebacks
```

**Guardrails**

- WhatsApp cost per booking capped via templates + preference center (NFR-COST-01).
- Refund clawback of commission (BR-SETL-03).
- Fraud freeze stops payouts.

---

## 6. Packaging by persona value

| Persona | Why they pay |
|---------|--------------|
| Hall Owner | Calendar integrity + discovery + payouts |
| Training Owner | Recurring slots + prepaid packages + CRM |
| Sports Owner | Peak yield + online collection |
| Vendor | Demand attached to venue bookings |
| Enterprise / Franchise | Multi-venue control + brand + API |

---

## 7. Billing mechanics (product requirements)

1. Subscription invoices via Razorpay Subscriptions or manual Enterprise invoices.
2. Marketplace commission settled in earnings ledger (gross, fees, net).
3. Featured credits as consumable entitlements.
4. All amounts INR paise; GST on SaaS fees as applicable.
5. Customer booking invoices separate from SaaS invoices.

---

## 8. Competitive monetization note

Avoid stacking customer-facing junk fees that destroy trust. Prefer **owner subscription + transparent commission** over surprise consumer surcharges unless A/B proves otherwise.

---

## 9. Founder decisions required ASAP

See also [11-risks-roadmap-metrics.md](11-risks-roadmap-metrics.md) open questions:

1. Final list prices for Starter/Professional  
2. Commission % by category  
3. Who bears Razorpay fees on refunds  
4. Whether customer convenience fee is allowed  
5. Trial length and credit card / UPI mandate for trial  
6. Annual discount policy  
