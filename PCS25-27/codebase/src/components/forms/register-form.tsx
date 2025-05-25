"use client";

import * as React from "react";
import { useRouter } from "next/navigation";
import { cn } from "@/lib/utils";
import { Icons } from "@/components/icons/icons";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import * as z from "zod";
import { registerFormSchema } from "@/lib/schema";
import { useToast } from "@/components/ui/use-toast";
import { ToastAction } from "@/components/ui/toast";
import Link from "next/link";
import { signup } from "@/app/register/action";

interface RegisterFormProps extends React.HTMLAttributes<HTMLDivElement> {}
type FormData = z.infer<typeof registerFormSchema>;

export function RegisterForm({ className, ...props }: RegisterFormProps) {
  const router = useRouter();
  const { toast } = useToast();
  const {
    handleSubmit,
    register,
    reset,
    formState: { errors, isSubmitting },
  } = useForm<FormData>({
    resolver: zodResolver(registerFormSchema),
  });

  async function onSubmit(data: FormData) {
    try {
      const res = await signup(data);
      const user = await JSON.parse(res);
      reset();
      console.log(user);
      if (user.data.user) {
        router.push("/");
        router.refresh();
        toast({
          variant: "default",
          title: "Welcome!",
          description: "Signup Successful",
        });
      } else {
        toast({
          variant: "destructive",
          title: "Uh oh! Something went wrong.",
          description: user.error?.code,
          action: <ToastAction altText="Try again">Try again</ToastAction>,
        });
      }
    } catch (error) {
      reset();
      console.log(error);
    }
    // try {
    //   const token = await handleLogin(data);
    //   reset();
    //   if (token.error == null) {
    //     router.push("/dashboard");
    //     router.refresh();
    //     toast({
    //       variant: "default",
    //       title: "Welcome back!.",
    //       description: "Login Successful",
    //     });
    //   } else
    //     toast({
    //       variant: "destructive",
    //       title: "Uh oh! Something went wrong.",
    //       description: token.error,
    //       action: <ToastAction altText="Try again">Try again</ToastAction>,
    //     });
    // } catch (error) {
    //   reset();
    //   console.log("login error", error);
    // }
  }

  return (
    <div
      className={cn("grid gap-6 border rounded-md p-6", className)}
      {...props}
    >
      <h1 className="text-2xl font-semibold">Register</h1>
      <form onSubmit={handleSubmit(onSubmit)}>
        <div className="grid gap-2">
          <div className="grid gap-2">
            <div>
              <Label className="sr-only" htmlFor="username">
                Email
              </Label>
              <Input
                {...register("username", { required: true })}
                id="username"
                placeholder="John Doe"
                type="text"
                autoCapitalize="none"
                autoCorrect="off"
                disabled={isSubmitting}
              />
              {errors?.username && (
                <p className="text-red-600 text-sm">
                  {errors?.username?.message}
                </p>
              )}
            </div>
            <div>
              <Label className="sr-only" htmlFor="email">
                Email
              </Label>
              <Input
                {...register("email", { required: true })}
                id="email"
                placeholder="name@example.com"
                type="email"
                autoCapitalize="none"
                autoComplete="email"
                autoCorrect="off"
                disabled={isSubmitting}
              />
              {errors?.email && (
                <p className="text-red-600 text-sm">{errors?.email?.message}</p>
              )}
            </div>
            <div>
              <Label className="sr-only" htmlFor="password">
                Email
              </Label>
              <Input
                {...register("password", { required: true })}
                id="password"
                placeholder="Password"
                type="password"
                disabled={isSubmitting}
              />
              {errors?.password && (
                <p className="text-red-600 text-sm">
                  {errors?.password?.message}
                </p>
              )}
            </div>
            <div>
              <Label className="sr-only" htmlFor="confirmPassword">
                Email
              </Label>
              <Input
                {...register("confirmPassword", { required: true })}
                id="confirmPassword"
                placeholder="Re-write password"
                type="password"
                disabled={isSubmitting}
              />
              {errors?.confirmPassword && (
                <p className="text-red-600 text-sm">
                  {errors?.confirmPassword?.message}
                </p>
              )}
            </div>
          </div>
          <Button disabled={isSubmitting}>
            {isSubmitting && (
              <Icons.spinner className="mr-2 h-4 w-4 animate-spin" />
            )}
            Sign Up
          </Button>
        </div>
      </form>
      <div>
        Already have an account?
        <Link href={"/login"} className="underline">
          Sign in
        </Link>
      </div>
    </div>
  );
}
