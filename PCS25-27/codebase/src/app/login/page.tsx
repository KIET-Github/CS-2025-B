"use client";
import { LoginForm } from "@/components/forms/login-form";
import React from "react";

const page = () => {
  return (
    <>
      <div className="flex flex-col justify-center items-center h-full">
        <LoginForm />
      </div>
    </>
  );
};

export default page;
