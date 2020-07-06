package de.joneug.mdal.util;

/*
 * Adopted from {@link org.eclipse.lsp4j.jsonrpc.messages.Either}
 */
public class MdalEither<L, R> {

	protected final L left;
	protected final R right;

	protected MdalEither(L left, R right) {
		super();
		this.left = left;
		this.right = right;
	}

	public static <L, R> MdalEither<L, R> forLeft(L left) {
		return new MdalEither<L, R>(left, null);
	}

	public static <L, R> MdalEither<L, R> forRight(R right) {
		return new MdalEither<L, R>(null, right);
	}

	public L getLeft() {
		return left;
	}

	public R getRight() {
		return right;
	}

	public boolean isLeft() {
		return left != null;
	}

	public boolean isRight() {
		return right != null;
	}

	public Object get() {
		if (isLeft())
			return left;
		if (isRight())
			return right;
		return null;
	}

}
