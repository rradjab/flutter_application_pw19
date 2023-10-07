// Autogenerated from Pigeon (v12.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#ifndef PIGEON_MESSAGES_G_H_
#define PIGEON_MESSAGES_G_H_
#include <flutter/basic_message_channel.h>
#include <flutter/binary_messenger.h>
#include <flutter/encodable_value.h>
#include <flutter/standard_message_codec.h>

#include <map>
#include <optional>
#include <string>

namespace pigeon_example {


// Generated class from Pigeon.

class FlutterError {
 public:
  explicit FlutterError(const std::string& code)
    : code_(code) {}
  explicit FlutterError(const std::string& code, const std::string& message)
    : code_(code), message_(message) {}
  explicit FlutterError(const std::string& code, const std::string& message, const flutter::EncodableValue& details)
    : code_(code), message_(message), details_(details) {}

  const std::string& code() const { return code_; }
  const std::string& message() const { return message_; }
  const flutter::EncodableValue& details() const { return details_; }

 private:
  std::string code_;
  std::string message_;
  flutter::EncodableValue details_;
};

template<class T> class ErrorOr {
 public:
  ErrorOr(const T& rhs) : v_(rhs) {}
  ErrorOr(const T&& rhs) : v_(std::move(rhs)) {}
  ErrorOr(const FlutterError& rhs) : v_(rhs) {}
  ErrorOr(const FlutterError&& rhs) : v_(std::move(rhs)) {}

  bool has_error() const { return std::holds_alternative<FlutterError>(v_); }
  const T& value() const { return std::get<T>(v_); };
  const FlutterError& error() const { return std::get<FlutterError>(v_); };

 private:
  friend class MessageApi;
  ErrorOr() = default;
  T TakeValue() && { return std::get<T>(std::move(v_)); }

  std::variant<T, FlutterError> v_;
};


// Generated class from Pigeon that represents data sent in messages.
class Message {
 public:
  // Constructs an object setting all non-nullable fields.
  Message();

  // Constructs an object setting all fields.
  explicit Message(
    const int64_t* length,
    const std::string* in_upper_case,
    const std::string* in_lower_case,
    const std::string* initial_text);

  const int64_t* length() const;
  void set_length(const int64_t* value_arg);
  void set_length(int64_t value_arg);

  const std::string* in_upper_case() const;
  void set_in_upper_case(const std::string_view* value_arg);
  void set_in_upper_case(std::string_view value_arg);

  const std::string* in_lower_case() const;
  void set_in_lower_case(const std::string_view* value_arg);
  void set_in_lower_case(std::string_view value_arg);

  const std::string* initial_text() const;
  void set_initial_text(const std::string_view* value_arg);
  void set_initial_text(std::string_view value_arg);


 private:
  static Message FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class MessageApi;
  friend class MessageApiCodecSerializer;
  std::optional<int64_t> length_;
  std::optional<std::string> in_upper_case_;
  std::optional<std::string> in_lower_case_;
  std::optional<std::string> initial_text_;

};

class MessageApiCodecSerializer : public flutter::StandardCodecSerializer {
 public:
  MessageApiCodecSerializer();
  inline static MessageApiCodecSerializer& GetInstance() {
    static MessageApiCodecSerializer sInstance;
    return sInstance;
  }

  void WriteValue(
    const flutter::EncodableValue& value,
    flutter::ByteStreamWriter* stream) const override;

 protected:
  flutter::EncodableValue ReadValueOfType(
    uint8_t type,
    flutter::ByteStreamReader* stream) const override;

};

// Generated interface from Pigeon that represents a handler of messages from Flutter.
class MessageApi {
 public:
  MessageApi(const MessageApi&) = delete;
  MessageApi& operator=(const MessageApi&) = delete;
  virtual ~MessageApi() {}
  virtual ErrorOr<Message> GetMessage(const std::string& text) = 0;

  // The codec used by MessageApi.
  static const flutter::StandardMessageCodec& GetCodec();
  // Sets up an instance of `MessageApi` to handle messages through the `binary_messenger`.
  static void SetUp(
    flutter::BinaryMessenger* binary_messenger,
    MessageApi* api);
  static flutter::EncodableValue WrapError(std::string_view error_message);
  static flutter::EncodableValue WrapError(const FlutterError& error);

 protected:
  MessageApi() = default;

};
}  // namespace pigeon_example
#endif  // PIGEON_MESSAGES_G_H_