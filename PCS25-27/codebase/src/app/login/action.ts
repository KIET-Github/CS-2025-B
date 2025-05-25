"use server";

import { createClient } from "@/utils/supabase/server";
import { loginFormSchema } from "@/lib/schema";
import { z } from "zod";

export async function login(formData: z.infer<typeof loginFormSchema>) {
  const supabase = createClient();

  // type-casting here for convenience
  // in practice, you should validate your inputs
  const { email, password } = formData;

  const res = await supabase.auth.signInWithPassword({
    email: email,
    password: password,
  });

  return JSON.stringify(res);
}
