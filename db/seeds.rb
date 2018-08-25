Patient.create(username: "Matt1", password: "abc123", physician_id: 1, medical_history: "hypertension, type 2 diabetes", active_problems: "glycemic control")
Patient.create(username: "Matt2", password: "abc234", physician_id: 1, medical_history: "deep vein thrombosis, ischemic stroke", active_problems: "warfarin management")
Patient.create(username: "Matt3", password: "abc345", physician_id: 2, medical_history: "afib on coumadin, heart failure", active_problems: "daily weights, low Na diet management")
Patient.create(username: "Matt4", password: "abc456", physician_id: 2, medical_history: "Stage 3 CKD, hypertension", active_problems: "dialysis")

Physician.create(username: "Doc1", npi: 3, password: "345abc")
Physician.create(username: "Doc2", npi: 2, password: "234abc")
