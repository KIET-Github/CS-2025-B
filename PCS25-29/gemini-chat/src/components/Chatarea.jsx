"use client";

import Markdown from "react-markdown";
import { useState, useEffect, useRef } from "react";
import { Send, Trash } from "lucide-react";
import Image from "next/image";

const ChatArea = () => {
  const messagesEndRef = useRef(null);
  const [input, setinput] = useState("");
  const [loading, setLoading] = useState(false);
  const [history, setHistory] = useState([
    {
      role: "assistant",
      content: "Hello! I'm your AI assistant. How can I help you today?",
    },
  ]);

  useEffect(() => {
    if (messagesEndRef.current) {
      messagesEndRef.current.scrollIntoView({ behavior: "smooth" });
    }
  }, [history]);

  async function chatting() {
    if (!input.trim()) return;
    
    setLoading(true);
    setHistory((oldHistory) => [
      ...oldHistory,
      {
        role: "user",
        content: input,
      },
      {
        role: "assistant",
        content: "Thinking...",
      },
    ]);
    setinput("");

    try {
      const response = await fetch('/api/chat', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          messages: [...history.filter(msg => msg.content !== "Thinking..."), { role: "user", content: input }],
        }),
      });

      if (!response.ok) {
        throw new Error('Failed to get response');
      }

      const data = await response.json();
      
      setHistory((oldHistory) => {
        const newHistory = oldHistory.slice(0, oldHistory.length - 1);
        newHistory.push({
          role: "assistant",
          content: data.content,
        });
        return newHistory;
      });
    } catch (error) {
      setHistory((oldHistory) => {
        const newHistory = oldHistory.slice(0, oldHistory.length - 1);
        newHistory.push({
          role: "assistant",
          content: "Oops! Something went wrong.",
        });
        return newHistory;
      });
      console.error(error);
    } finally {
      setLoading(false);
    }
  }

  function handleKeyDown(e) {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      chatting();
    }
  }

  function reset() {
    setHistory([
      {
        role: "assistant",
        content: "Hello! I'm your AI assistant. How can I help you today?",
      },
    ]);
    setinput("");
  }

  return (
    <div className="relative flex px-2 justify-center max-w-3xl min-h-dvh w-full pt-6 bg-gray-900 rounded-t-3xl max-h-screen shadow shadow-slate-900">
      <div className="flex text-sm md:text-base flex-col pt-10 pb-16 w-full flex-grow flex-1 rounded-3xl shadow-md overflow-y-auto">
        {history.map((item, index) => (
          <div
            key={index}
            className={`chat ${
              item.role === "assistant" ? "chat-start" : "chat-end"
            }`}
          >
            <div className="chat-image avatar">
              <div className="w-6 md:w-10 rounded-full">
                <Image
                  alt={item.role === "assistant" ? "AI" : "User"}
                  src={item.role === "assistant" ? "/geminis.jpeg" : "/user.jpg"}
                  width={50}
                  height={50}
                />
              </div>
            </div>
            <div className="chat-header mx-2 font-semibold opacity-80">
              {item.role === "assistant" ? "AI" : "You"}
            </div>
            <div
              className={`chat-bubble font-medium ${
                item.role === "assistant" ? "chat-bubble-primary" : ""
              }`}
            >
              <Markdown>{item.content}</Markdown>
            </div>
          </div>
        ))}
        <div ref={messagesEndRef} />
      </div>

      <div className="absolute px-2 bottom-2 w-full flex gap-1">
        <button
          className="btn btn-outline shadow-md btn-error rounded-3xl backdrop-blur"
          title="Clear chat"
          onClick={reset}
        >
          <Trash />
        </button>
        <textarea
          value={input}
          required
          rows={1}
          onKeyDown={handleKeyDown}
          onChange={(e) => setinput(e.target.value)}
          placeholder="Type your message..."
          className="textarea backdrop-blur textarea-primary w-full mx-auto bg-opacity-60 font-medium shadow rounded-3xl"
        />
        <button
          className={`btn rounded-3xl shadow-md ${
            loading
              ? "btn-accent cursor-wait pointer-events-none"
              : "btn-primary"
          }`}
          title="Send message"
          onClick={chatting}
        >
          {loading ? (
            <span className="loading loading-spinner loading-sm"></span>
          ) : (
            <Send />
          )}
        </button>
      </div>
    </div>
  );
};

export default ChatArea;
